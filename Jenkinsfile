pipeline {
    environment {
      registry = "gustavoapolinario/docker-test"
      registryCredential = 'dockerhub'
      dockerImage = ''
    }
    agent any
    stages {
      stage('Test') {
        steps{
           sh """
              ls
            """
        }
      }
      stage('Deploy Kubernetes Application') {
        steps{
          sh """
            ansible-playbook -i inventory deploy.yml -vvv
          """  
        }
      }

    }
}