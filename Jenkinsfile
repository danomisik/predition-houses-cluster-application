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
          sh 'python3 -m venv venv'
          sh """
          . venv/bin/activate
          make install
          pip install openshift
          pip install boto
          ansible-playbook -i inventory deploy.yml
          """ 
        }
      }

    }
}