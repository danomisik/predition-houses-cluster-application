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
              ls -l /usr/local/bin/kubectl
              ls -l /usr/bin/kubectl
              /usr/local/bin/kubectl --help
              /usr/bin/kubectl --help
              aws eks --region eu-central-1 update-kubeconfig --name eks-housepred-services --kubeconfig ~/.kube/eks-housepred-services
              export KUBECONFIG=~/.kube/eks-housepred-services
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