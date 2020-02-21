pipeline {
    environment {
      registryCredential = 'dockerhub'
      registry = "danielmisik/udacity:ml-service"
      dockerImage = ''
    }
    agent any
    stages {

       stage('Install dependencies') {
        steps {
          sh 'python3 -m venv venv'
          sh """
          . venv/bin/activate
          make install
          """
        }
      }
      stage('Lint app') {
        steps {
          sh """
          . venv/bin/activate
          make lint
          """
        }
      }
      stage('Build and Push Image') {
        steps{
          script {
            def appimage = docker.build registry + ":$BUILD_NUMBER"  
            docker.withRegistry( '', registryCredential ) {
              appimage.push()
              appimage.push('latest')
            }
          }
        }
      }
      stage('Deploy Kubernetes Application') {
        steps{
          script{
            def image_id = registry + ":$BUILD_NUMBER"
            sh """
              export PATH=/var/lib/jenkins/.local/bin/:$PATH
              aws eks --region eu-central-1 update-kubeconfig --name eks-housepred-services --kubeconfig /var/lib/jenkins/.kube/eks-housepred-services
              export KUBECONFIG=/var/lib/jenkins/.kube/eks-housepred-services
              kubectl get svc 2>&1
              ansible-playbook -i inventory deploy.yml --extra-vars \"image_id=${image_id}\"" -vvv
            """ 
          } 
        }
      }

    }
}