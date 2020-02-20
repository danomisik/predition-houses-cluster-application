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
              export PATH=/var/lib/jenkins/.local/bin/:$PATH
              echo $PATH
              find / -name kubectl -print 2>/dev/null
              /usr/local/bin/kubectl --help
              /usr/bin/kubectl --help
              kubectl get svc 2>&1
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