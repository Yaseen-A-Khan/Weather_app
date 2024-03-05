pipeline {
    agent any

    environment {
        DOCKER_USER = "${env.DOCKER_USER}"
        DOCKER_PASS = "${env.DOCKER_PASS}"
        APP_NAME = "${env.APP_NAME}"
        ENV_PASSWORD = "${env.ENV_PASSWORD}"
    }

    stages {
        stage('checkout source') {
            steps {
                checkout scm
            }
        }

        stage('decrypt .env file') {
            steps {
                script {
                    sh 'openssl aes-256-cbc -d -in .env.enc -out .env -k $ENV_PASSWORD -pbkdf2'
                }
            }
        }
        stage('Login to Docker') {
            steps {
                script {
                    sh 'echo $DOCKER_PASS | sudo docker login -u $DOCKER_USER --password-stdin' 
                    echo 'Login Completed'
                }
            }
        }
        stage('Build Docker image') {
            steps {
                script {
                    sh 'sudo docker build -t ${DOCKER_USER}/${APP_NAME}:v1.0 .'
                    echo 'Image build is completed'
                }
            }
        }
        stage('Push it to Docker Hub') {
            steps {
                script {
                    sh 'sudo docker push ${DOCKER_USER}/${APP_NAME}:v1.0'
                    echo 'Succesfully Pushed image into DockerHub Repo'
                }
            }
        }
    }
}