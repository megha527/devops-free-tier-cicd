pipeline {
    agent any

    environment {
        TF_IN_AUTOMATION = "true"
        AWS_DEFAULT_REGION = "ap-south-1"
    }

    stages {

        stage('Clean Workspace') {
            steps {
                deleteDir()
            }
        }

        stage('Checkout Repo') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                dir('terraform') {
                    withCredentials([
                        string(credentialsId: 'aws_access_key_id', variable: 'AWS_ACCESS_KEY_ID'),
                        string(credentialsId: 'aws_secret_access_key', variable: 'AWS_SECRET_ACCESS_KEY')
                    ]) {
                        sh '''
                            terraform init
                        '''
                    }
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir('terraform') {
                    withCredentials([
                        string(credentialsId: 'aws_access_key_id', variable: 'AWS_ACCESS_KEY_ID'),
                        string(credentialsId: 'aws_secret_access_key', variable: 'AWS_SECRET_ACCESS_KEY')
                    ]) {
                        sh '''
                            terraform apply -auto-approve
                        '''
                    }
                }
            }
        }

        stage('Capture Terraform Outputs') {
            steps {
                dir('terraform') {
                    sh '''
                        terraform output -json > terraform-outputs.json
                    '''
                }
            }
        }
    }

    post {
        success {
            echo "Terraform pipeline completed successfully."
        }
        failure {
            echo "Terraform pipeline failed."
        }
    }
}
