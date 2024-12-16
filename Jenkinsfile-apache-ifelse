pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS = 'dockerhub-credentials'
        DOCKER_IMAGE_NAME = 'makxies24/vue-portfolio'
        DOCKER_TAG = "${env.BUILD_NUMBER}"
        DOCKER_PORT = '80'
        CONTAINER_NAME = 'vue-portfolio-container'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/CubeDenmark/devautomation.git'
            }
        }

        stage('Install Node.js v21') {
            steps {
                script {
                    sh '''
                    if [ ! -d "$HOME/.nvm" ]; then
                        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
                    fi

                    export NVM_DIR="$HOME/.nvm"
                    [ -s "$NVM_DIR/nvm.sh" ] && \\. "$NVM_DIR/nvm.sh"

                    if ! nvm list | grep -q "v21.0.0"; then
                        nvm install 21
                        nvm alias default 21
                    fi
                    nvm use 21
                    '''
                }
            }
        }

        stage('Install Dependencies') {
            steps {
                script {
                    sh '''
                    export NVM_DIR="$HOME/.nvm"
                    [ -s "$NVM_DIR/nvm.sh" ] && \\. "$NVM_DIR/nvm.sh"
                    nvm use 21
                    npm install
                    '''
                }
            }
        }

        stage('Build Vue.js App') {
            steps {
                script {
                    sh '''
                    export NVM_DIR="$HOME/.nvm"
                    [ -s "$NVM_DIR/nvm.sh" ] && \\. "$NVM_DIR/nvm.sh"
                    nvm use 21
                    npm run build
                    '''
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
                    sh '''
                    docker ps -q -f name=$CONTAINER_NAME | xargs -r docker stop
                    docker ps -aq -f name=$CONTAINER_NAME | xargs -r docker rm
                    '''
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    sh 'docker run -d --name $CONTAINER_NAME -p $DOCKER_PORT:80 $DOCKER_IMAGE_NAME:$DOCKER_TAG'
                }
            }
        }

        stage('Test App on Port') {
            steps {
                script {
                    sh '''
                    status=$(curl -o /dev/null -s -w "%{http_code}" http://localhost:$DOCKER_PORT)
                    if [ "$status" -ne 200 ]; then
                        echo "Application failed to respond with 200 OK."
                        exit 1
                    fi
                    '''
                }
            }
        }
    }

    post {
        success {
            echo 'Build, push, and run Docker container was successful!'
            cleanWs()
        }
        failure {
            echo 'Something went wrong during the pipeline execution.'
            cleanWs()
        }
    }
}
