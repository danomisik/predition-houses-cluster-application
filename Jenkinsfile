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
          sh 'wget -O /bin/hadolint https://github.com/hadolint/hadolint/releases/download/v1.16.3/hadolint-Linux-x86_64 &&\'
          sh 'chmod +x /bin/hadolint'
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