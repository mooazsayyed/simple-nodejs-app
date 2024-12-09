# Stage 1: Build Stage
FROM node:16-alpine AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy package files first to leverage Docker's caching mechanism
COPY package*.json ./

# Install production dependencies only
RUN npm install --production

# Copy the rest of the application code
COPY . .

# Stage 2: Production Image
FROM node:16-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy only the necessary files from the build stage
COPY --from=builder /app .

# Expose the application port
EXPOSE 3000

# Start the application
ENTRYPOINT ["npm", "start"]
