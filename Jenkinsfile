pipeline{
    agent any
    stages{
        stage("Install"){
            steps{
                sh "yum install terraform -y"
            }
        }   
        stage("TF Init"){
            steps{
                sh "terraform init"
            }
        }
        stage("TF Validate"){
            steps{
                sh "terraform validate"
            }
        }
        stage("TF Plan"){
            steps{
                sh "terraform plan"
            }
        }
        stage("TF Apply"){
            steps{
                echo "Executing Terraform Apply"
            }
        }
        stage("Invoke Lambda"){
            steps{
                sh "terraform apply --auto-approve"
            }
        }
    }
}
