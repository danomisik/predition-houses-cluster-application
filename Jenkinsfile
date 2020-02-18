pipeline {
    environment {
      registry = "gustavoapolinario/docker-test"
      registryCredential = 'dockerhub'
      dockerImage = ''
    }
    agent any
    stages {
      stage('AWC Credentials') {
        steps{
          withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'MyCredentials', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
            sh """
              mkdir -p ~/.aws
              echo "[default]" >~/.aws/credentials
              echo "[default]" >~/.boto
              echo "aws_access_key_id = ${AWS_ACCESS_KEY_ID}" >>~/.boto
              echo "aws_secret_access_key = ${AWS_SECRET_ACCESS_KEY}" >>~/.boto
              echo "aws_access_key_id = ${AWS_ACCESS_KEY_ID}" >>~/.aws/credentials
              echo "aws_secret_access_key = ${AWS_SECRET_ACCESS_KEY}" >>~/.aws/credentials
              export KUBECONFIG=/home/ubuntu/.kube/eks-housepred-services
            """
          }
        }
      }
      stage('Deploy Kubernetes Application') {
        steps{
          ansiblePlaybook playbook: 'deploy.yml', inventory: 'inventory'
        }
      }

    }
}