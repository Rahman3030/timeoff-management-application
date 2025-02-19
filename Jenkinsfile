pipeline {
    agent any
    environment {
        DOCKER_IMAGE = 'rahman303/timeoff-local'  // Your Docker Hub username/image
        EC2_IP = '52.66.245.0'  // Your EC2 public IP
        UPDATE_SCRIPT = 'update-ec2.sh'  // Script to handle deployment
    }
    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/Rahman3030/timeoff-management-application.git', branch: 'master'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }
        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-rahman303-rahman303',
                    usernameVariable: 'DOCKERHUB_USER',
                    passwordVariable: 'DOCKERHUB_TOKEN'
                )]) {
                    sh "echo $DOCKERHUB_TOKEN | docker login --username $DOCKERHUB_USER --password-stdin"
                    sh 'docker push $DOCKER_IMAGE'
                }
            }
        }
        stage('Deploy to EC2') {
            steps {
                sh "scp -i 'Ailaban-app-key.pem' $UPDATE_SCRIPT ubuntu@$EC2_IP:/home/ubuntu/update-ec2.sh"
                sshagent(['ec2-ssh-key']) {
                    sh """
                        ssh -o StrictHostKeyChecking=no ubuntu@$EC2_IP \\
                            "chmod +x /home/ubuntu/update-ec2.sh && \\
                             /home/ubuntu/update-ec2.sh $DOCKER_IMAGE"
                    """
                }
            }
        }
    }
}
