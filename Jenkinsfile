pipeline {
    agent any
    stages {
      stage('Lint app') {
        steps {
          sh '. venv/bin/activate'
          sh 'make lint'
        }
      }
    }
}