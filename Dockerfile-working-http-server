# Step 1: Use a lightweight base image (e.g., Alpine Linux)
FROM node:21-alpine

# Step 2: Set the working directory inside the container
WORKDIR /app

# Step 3: Copy package.json and package-lock.json
COPY package*.json ./

# Step 4: Install the dependencies from package.json
RUN npm install

# Step 5: Copy the entire project into the container
COPY . .

# Step 6: Build the Vue.js app (production build)
RUN npm run build

# Step 7: Install a simple static file server (http-server) to serve the build
RUN npm install -g http-server

# Step 8: Expose port 8080 to access the app
EXPOSE 8081

# Step 9: Command to run the app using http-server
CMD ["http-server", "dist", "-p", "8081"]
