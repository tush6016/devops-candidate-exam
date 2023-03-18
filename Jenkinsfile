pipeline{
    agent any
    stages{
        stage("Clone"){
            steps{
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/tush6016/devops-candidate-exam.git']]])
            }
        }    
        stage("TF Init"){
            steps{
                sh ''' 
                  terraform init
                '''
            }
        }
        stage("TF Validate"){
            steps{
                sh '''
                  terraform validate
                '''
            }
        }
        stage("TF Plan"){
            steps{
                sh '''
                  terraform plan
                '''
            }
        }
        stage("TF Apply"){
            steps{
                sh '''
                  terraform apply --auto-approve
                '''
            }
        }
        stage("Invoke Lambda"){
            steps{
                sh '''
                  aws lambda invoke --function-name lambda-function --payload \"api-payload\" --log-type Tail response.txt
                '''
                sh '''
                  cat response.txt
                  '''
            }
        }
    }
}
