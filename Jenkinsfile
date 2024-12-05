pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS = 'dockerhub-credentials'
        DOCKER_IMAGE_NAME = 'makxies24/vue-portfolio'
        DOCKER_TAG = 'v1.0'
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/CubeDenmark/devautomation.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                script {
                    sh 'sudo npm install'
                }
            }
        }

        stage('Build Vue.js App') {
            steps {
                script {
                    sh 'sudo npm run build'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'sudo docker build -t $DOCKER_IMAGE_NAME:$DOCKER_TAG .'
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: "$DOCKER_CREDENTIALS", usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh 'sudo echo $DOCKER_PASSWORD | sudo docker login -u $DOCKER_USERNAME --password-stdin'
                    }
                    sh 'sudo docker push $DOCKER_IMAGE_NAME:$DOCKER_TAG'
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