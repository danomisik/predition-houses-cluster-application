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
            pip list
            pip install openshift
            pip list
            whereis python
            whoami
            sudo ansible-playbook -i inventory deploy.yml -vvv
            """ 
          }
        }
      }

    }
}