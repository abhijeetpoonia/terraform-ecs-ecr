# Use the official Node.js runtime as the base image
FROM node:18-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json (if available)
COPY package*.json ./

# Clear npm cache and install dependencies
RUN npm cache clean --force
RUN npm install --production

# Copy the rest of the application code
COPY . .

# Expose port 8000
EXPOSE 8000

# Start the application
CMD ["npm", "start"]
