# Step 1: Use a lightweight base image (e.g., Alpine Linux) for building the app
FROM node:21-alpine AS build-stage

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

# Step 7: Use Apache HTTP server (httpd) to serve the app
FROM httpd:alpine

# Step 8: Copy the built Vue.js app to Apache's document root
COPY --from=build-stage /app/dist/ /usr/local/apache2/htdocs/

# Step 9: Expose port 80 to access the app
EXPOSE 80

# Step 10: Apache already runs in the foreground, no need to specify CMD
# The default entry point for Apache is already set, so no need to specify it here
