pipeline {
    agent any
    stages {
      stage('Install dependencies') {
        steps {
          sh '. venv/bin/activate'
          sh 'make lint'
          sh 'python3 -m venv venv'
          sh '. venv/bin/activate'
          sh 'make install'
        }
      }
      stage('Lint app') {
        steps {
          sh '. venv/bin/activate'
          sh 'make lint'
        }
      }
    }
}