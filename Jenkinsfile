pipeline {
    environment {
      registry = "gustavoapolinario/docker-test"
      registryCredential = 'dockerhub'
      dockerImage = ''
    }
    agent any
    stages {
      stage('Deploy Kubernetes Application') {
        steps{
          withAWS(region:'eu-central-1',credentials:'aws-static') {
            sh """
            pip list
            pip install openshift
            pip list
            whereis python
            whoami
            su - ubuntu
            ansible-playbook -i inventory deploy.yml -vvv
            """ 
          }
        }
      }

    }
}