pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/CubeDenmark/devautomation.git', branch: 'main'
            }
        }
    }

    post {
        success {
            echo 'Checkout stage completed successfully!'
        }
        failure {
            echo 'Checkout stage failed. Please check the repository and branch configuration.'
        }
    }
}
