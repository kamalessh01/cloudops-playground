# Use a lightweight Node.js base image
FROM node:18-alpine

# Set working directory inside container
WORKDIR /usr/src/app

# Copy only package files first (for better build caching)
COPY package*.json ./

# Install dependencies
RUN npm install --production

# Copy rest of the application files
COPY . .

# Expose the port your app listens on
EXPOSE 3000

# Define default command to run your app
CMD ["npm", "start"]