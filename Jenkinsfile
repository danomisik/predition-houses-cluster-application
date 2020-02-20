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
              echo $PATH
              find / -name kubectl -print 2>/dev/null
              kubectl get svc
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