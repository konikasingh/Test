# Use official Node.js image
FROM node:18-alpine

# Set working directory inside the container
WORKDIR /app

# Copy only package.json and install deps first (layer caching)
COPY src/package*.json ./

# Install dependencies
RUN npm install

# Copy app files
COPY src/ .

# Expose port
EXPOSE 3000

# Start the app
CMD ["npm", "start"]
