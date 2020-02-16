pipeline {
    environment {
      registry = "gustavoapolinario/docker-test"
      registryCredential = 'dockerhub'
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
      stage('Building image') {
        steps{
          script {
            dockerImage = docker.build "danielmisik/udacity:ml-service"
          }
        }
      }
      stage('Push Image') {
        steps{
          script {
            docker.withRegistry( '', registryCredential ) {
              dockerImage.push()
            }
          }
        }
      }
      stage('Deploy Kubernetes Application') {
        steps{
          ansiblePlaybook playbook: 'deploy.yml', inventory: 'inventory'
        }
      }

    }
}