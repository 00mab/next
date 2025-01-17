# Step 1: Use Node.js official image
FROM node:18 AS build

# Step 2: Set the working directory inside the container
WORKDIR /app

# Step 3: Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Step 4: Install dependencies
RUN npm install

# Step 5: Copy the entire application
COPY . .

# Step 6: Build the Next.js application for production
RUN npm run build

# Step 7: Use a smaller image for production
FROM node:18-slim

# Set the working directory
WORKDIR /app

# Step 8: Copy the build output from the build stage
COPY --from=build /app ./

# Step 9: Expose port 3000
EXPOSE 3000

# Step 10: Run the app in production mode
CMD ["npm", "start"]
