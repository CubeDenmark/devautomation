pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS = 'dockerhub-credentials'
        DOCKER_IMAGE_NAME = 'makxies24/vue-portfolio'
        DOCKER_TAG = 'v1.0'
        DOCKER_PORT = '80' // External port to avoid conflicts
        CONTAINER_NAME = 'vue-portfolio-container'
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

        stage('Clean Up Existing Container') {
            steps {
                script {
                    // Stop and remove the container if it exists
                    sh '''
                    if [ $(docker ps -q -f name=$CONTAINER_NAME) ]; then
                        docker stop $CONTAINER_NAME && docker rm $CONTAINER_NAME
                    elif [ $(docker ps -aq -f name=$CONTAINER_NAME) ]; then
                        docker rm $CONTAINER_NAME
                    fi
                    '''
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Run the Docker container with the specified name
                    sh 'docker run -d --name $CONTAINER_NAME -p $DOCKER_PORT:80 $DOCKER_IMAGE_NAME:$DOCKER_TAG'
                }
            }
        }

        stage('Test App on Port') {
            steps {
                script {
                    // Test if the application is running
                    sh 'curl -s http://localhost:$DOCKER_PORT'
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
