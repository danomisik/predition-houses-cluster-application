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
          sh 'pip install openshift'
          ansiblePlaybook playbook: 'deploy.yml', inventory: 'inventory'
        }
      }

    }
}