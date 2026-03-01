pipeline {
    agent { label 'docker react netflix' }

    environment{
        DOCKER_IMAGE = 'cloudcrates/netflix-app'
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
                    dockerImage = docker.build("${DOCKER_IMAGE}:${BUILD_NUMBER}")
                }
            }
        } 

        stage('Push Image') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub-creds') {
                        dockerImage.push()
                    }
                }
            }
        } 

        stage('Deploy Container') {
            steps {
                sh "docker stop ${CONTAINER_NAME} || true"
                sh "docker rm ${CONTAINER_NAME} || true"
                sh "docker run -d -p 3000:80 --name ${CONTAINER_NAME} ${DOCKER_IMAGE}:${BUILD_NUMBER}"
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