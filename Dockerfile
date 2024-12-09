# Stage 1: Build Stage
FROM node:16-alpine AS build

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json first to leverage Docker's cache
COPY package*.json ./

# Install dependencies (including dev dependencies like mocha and chai-http)
RUN npm install --production

# Copy the rest of the application code
COPY . .

# Stage 2: Production Stage
FROM node:16-alpine

# Set working directory
WORKDIR /app

# Copy only necessary files (production dependencies and app code)
COPY --from=build /app /app

# Expose the port that the app will run on
EXPOSE 3000

# Start the application
CMD ["npm", "start"]
