pipeline {
    agent any
    environment {
        DOCKER_IMAGE    = 'rahman303/timeoff-app'    // Docker Hub image name
        DOCKER_TAG      = "${env.BUILD_NUMBER}"      // Tag with build number
        DOCKERHUB_USER  = credentials('dockerhub-rahman303-rahman303').userName
        DOCKERHUB_TOKEN = credentials('dockerhub-rahman303-rahman303').password
        EC2_IP          = '52.66.245.0'              // Your EC2 public IP
        SSH_KEY         = 'Ailaban-app-key.pem'      // Path to your SSH key (Linux path)
        UPDATE_SCRIPT   = 'update-ec2.sh'            // Deployment script
    }
    stages {
        stage('Checkout') {
            steps {
                git url: 'git@github.com:Rahman3030/timeoff-management-application.git',
                    branch: 'master',
                    credentialsId: 'GitHub-SSH'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} ."
            }
        }
        stage('Push to Docker Hub') {
            steps {
                sh "echo ${DOCKERHUB_TOKEN} | docker login -u ${DOCKERHUB_USER} --password-stdin"
                sh "docker push ${DOCKER_IMAGE}:${DOCKER_TAG}"
            }
        }
        stage('Deploy to EC2') {
            steps {
                // Transfer deployment script to EC2
                sh "scp -i ${SSH_KEY} ${UPDATE_SCRIPT} ubuntu@${EC2_IP}:/home/ubuntu/update-ec2.sh"
                
                // Execute deployment script on EC2
                sh '''
                    ssh -o StrictHostKeyChecking=no -i ${SSH_KEY} ubuntu@${EC2_IP} \\
                        "chmod +x /home/ubuntu/update-ec2.sh && \\
                         /home/ubuntu/update-ec2.sh ${DOCKER_IMAGE}:${DOCKER_TAG}"
                '''
            }
        }
    }
}
