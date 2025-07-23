pipeline {
    agent any

    environment {
        GIT_COMMIT = "${env.GIT_COMMIT ?: 'latest'}"
        IMAGE = "miteshsaste/devops-nodejs-app:${GIT_COMMIT}"
        SSH_KEY_PATH = '/home/ubuntu/devops-server-key' 
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'develop', url: 'https://github.com/Mitesh-Saste/devops-pipeline-nodejs.git'
            }
        }

        stage('Build & Push Docker Image') {
            steps {
                script {
                    withDockerRegistry([credentialsId: 'DockerHub', url: '']) {
                        sh 'chmod +x scripts/build_and_push.sh'
                        sh './scripts/build_and_push.sh'
                    }
                }
            }
        }

        stage('Terraform Apply - Provision Infra') {
            steps {
                dir('infra') {
                    sh 'terraform init'
                    timeout(time: 30, unit: 'MINUTES') {
                        sh 'terraform apply -auto-approve'
                    }
                }
            }
        }

        stage('Prepare Ansible Hosts') {
            steps {
                script {
                    def ec2_ip = sh(script: "terraform -chdir=infra output -raw ec2_pub_ip", returnStdout: true).trim()
                    writeFile file: 'ansible/hosts.ini', text: """
                    [app_server]
                    ${ec2_ip} ansible_user=ubuntu ansible_ssh_private_key_file=${SSH_KEY_PATH}
                    """
                }
            }
        }

        stage('Ansible Deployment') {
            steps {
                timeout(time: 10, unit: 'MINUTES') {
                    sh 'ansible-playbook -i ansible/hosts.ini ansible/deploy.yml'
                }
            }
        }
    }

    post {
        success {
            echo "Pipeline executed successfully!"
        }
        failure {
            echo "Pipeline failed. Check logs."
        }
        always {
            cleanWs()
        }
    }
}