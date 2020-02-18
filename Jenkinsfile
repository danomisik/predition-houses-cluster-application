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
            pip install awscli
            aws eks --region eu-central-1 update-kubeconfig --name eks-housepred-services --kubeconfig ~/.kube/eks-housepred-services
            export KUBECONFIG=~/.kube/eks-housepred-services
            kubectl get svc
            pip list
            pip install openshift
            pip list
            whereis python
            whoami
            ansible-playbook -i inventory deploy.yml -vvv
            """ 
          }
        }
      }

    }
}