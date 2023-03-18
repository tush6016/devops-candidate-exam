pipeline{
    agent any
    stages{
        stage("Clone"){
            steps{
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/tush6016/devops-candidate-exam.git']]])
            }
        }
        stage("Install"){
            steps{
                sh 'echo "yum install terraform -y"'
            }
        }
        stage{
            steps{
                sh 'echo "cd"'
            }
        }    
        stage("TF Init"){
            steps{
                sh 'echo "terraform init"'
            }
        }
        stage("TF Validate"){
            steps{
                sh 'echo "terraform validate"'
            }
        }
        stage("TF Plan"){
            steps{
                sh 'echo "terraform plan"'
            }
        }
        stage("TF Apply"){
            steps{
                sh 'echo "terraform apply --auto-approve"'
            }
        }
        stage("Invoke Lambda"){
            steps{
                sh 'echo "aws lambda invoke --function-name lambda-function --payload \"api-payload\" --log-type Tail response.txt"'
                sh 'echo "cat response.txt"'
            }
        }
    }
}
