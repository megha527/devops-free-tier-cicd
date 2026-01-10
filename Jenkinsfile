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
                    sh '''
                        terraform init -input=false
                    '''
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir('terraform') {
                    sh '''
                        terraform apply -auto-approve -input=false
                    '''
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
