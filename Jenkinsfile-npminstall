pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS = 'dockerhub-credentials'
        DOCKER_IMAGE_NAME = 'makxies24/vue-portfolio'
        DOCKER_TAG = 'v1.0'
        DOCKER_PORT = '80'
        CONTAINER_NAME = 'vue-portfolio-container'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/CubeDenmark/devautomation.git'
            }
        }

        stage('Install Node.js v21 if Not Installed') {
            steps {
                script {
                    // Install Node.js v21 using nvm if not already installed
                    sh '''
                    # Install nvm if not already installed
                    if [ ! -d "$HOME/.nvm" ]; then
                        echo "Installing nvm..."
                        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
                    fi
                    
                    # Initialize nvm
                    export NVM_DIR="$HOME/.nvm"
                    [ -s "$NVM_DIR/nvm.sh" ] && \\. "$NVM_DIR/nvm.sh"

                    # Check if Node.js v21 is installed; install it if not
                    if ! nvm list | grep -q "v21.0.0"; then
                        echo "Installing Node.js v21..."
                        nvm install 21
                        nvm alias default 21
                    else
                        echo "Node.js v21 is already installed."
                    fi
                    '''
                }
            }
        }

        stage('Install Dependencies') {
            steps {
                script {
                    // Use Node.js v21 to ensure compatibility
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
                    sh 'docker run -d --name $CONTAINER_NAME -p $DOCKER_PORT:80 $DOCKER_IMAGE_NAME:$DOCKER_TAG'
                }
            }
        }

        stage('Test App on Port') {
            steps {
                script {
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
