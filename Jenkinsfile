pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS = 'dockerhub-credentials'
        DOCKER_IMAGE_NAME = 'makxies24/vue-portfolio'
        DOCKER_TAG = 'v1.0'
        DOCKER_PORT = '8081'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/CubeDenmark/devautomation.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                script {
                    sh 'npm install'
                }
            }
        }

        stage('Build Vue.js App') {
            steps {
                script {
                    sh 'npm run build'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t $DOCKER_IMAGE_NAME:$DOCKER_TAG .'
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: "$DOCKER_CREDENTIALS", usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh 'echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin'
                    }
                    sh 'docker push $DOCKER_IMAGE_NAME:$DOCKER_TAG'
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Run the Docker container on port 8081
                    sh 'docker run -d -p $DOCKER_PORT:80 $DOCKER_IMAGE_NAME:$DOCKER_TAG'
                    // Verify the container is running
                    sh 'docker ps'
                }
            }
        }

        stage('Test App on Port 8081') {
            steps {
                script {
                    // Optionally, you can add a curl or wget to test if the app is running
                    sh 'curl http://localhost:$DOCKER_PORT'
                }
            }
        }
    }

    post {
        success {
            echo 'Build, push, and run Docker container was successful!'
        }
        failure {
            echo 'Something went wrong during the pipeline execution.'
        }
    }
}
