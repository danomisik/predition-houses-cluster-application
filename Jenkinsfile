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
          sh """
          ansible-playbook -i inventory deploy.yml -e 'ansible_python_interpreter=/usr/bin/python3.6' -vvv
          """ 
        }
      }

    }
}