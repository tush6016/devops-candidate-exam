pipeline{
    agent any
    stages{
        stage("Install"){
            steps{
                echo "yum install terraform -y"
            }
        }   
        stage("TF Init"){
            steps{
                echo "terraform init"
            }
        }
        stage("TF Validate"){
            steps{
                echo "terraform validate"
            }
        }
        stage("TF Plan"){
            steps{
                echo "terraform plan"
            }
        }
        stage("TF Apply"){
            steps{
                echo "terraform apply --auto-approve"
            }
        }
        stage("Invoke Lambda"){
            steps{
                echo "aws lambda invoke --function-name lambda-function --payload 'api-payload' --log-type Tail response.txt"
                echo "cat response.txt"
            }
        }
    }
}
