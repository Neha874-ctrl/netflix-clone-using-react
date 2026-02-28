pipeline {
    agent { label 'docker react netflix' }

    environment{
        IMAGE_NAME = 'netflix-app'
        CONTAINER_NAME = 'netflix-app-container'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Neha874-ctrl/netflix-clone-using-react.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the image and store as a Docker image object
                    image = docker.build("${IMAGE_NAME}:latest")
                }
            }
        } 

        stage('Run Docker Container') {
            steps {
                script {
                    // Stop and remove previous container if exists
                    sh "docker stop ${CONTAINER_NAME} || true"
                    sh "docker rm ${CONTAINER_NAME} || true"

                    // Run the new container
                    sh "docker run -d -p 3000:80 --name ${CONTAINER_NAME} ${IMAGE_NAME}:latest"
                }
            }
        } 
    }

    post {
        success {
            echo 'Docker container deployed successfully!!'
        }
        failure {
            echo 'Build failed!!'
        }
    }
}