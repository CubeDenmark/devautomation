pipeline {
    agent any

    environment {
        // Define your DockerHub credentials here (if not using Jenkins' credentials plugin)
        DOCKER_CREDENTIALS = 'dockerhub-credentials'  // Name of the Jenkins credentials
        DOCKER_IMAGE_NAME = 'makxies24/vue-portfolio'  // Change this to your Docker Hub repo name
        DOCKER_TAG = 'v1.0'  // Change this to your versioning scheme, if needed
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from the GitHub repository
                git 'https://github.com/CubeDenmark/devautomation.git'  // Replace with your repository URL
            }
        }

        stage('Install Dependencies') {
            steps {
                script {
                    // Install dependencies for the Vue.js app
                    sh 'npm install'
                }
            }
        }

        stage('Build Vue.js App') {
            steps {
                script {
                    // Build the Vue.js app
                    sh 'npm run build'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    sh 'docker build -t $DOCKER_IMAGE_NAME:$DOCKER_TAG .'
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    // Login to Docker Hub using stored credentials
                    withCredentials([usernamePassword(credentialsId: "$DOCKER_CREDENTIALS", usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh 'echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin'
                    }
                    
                    // Push the image to Docker Hub
                    sh 'docker push $DOCKER_IMAGE_NAME:$DOCKER_TAG'
                }
            }
        }
    }

    post {
        success {
            echo 'Build and push to Docker Hub was successful!'
        }
        failure {
            echo 'Something went wrong during the pipeline execution.'
        }
    }
}
