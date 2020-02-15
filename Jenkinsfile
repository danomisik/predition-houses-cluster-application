pipeline {
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
    }
}