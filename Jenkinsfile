pipeline {
  agent any
  stages {
    stage('Git Checkout') {
      steps {
        git(url: 'https://github.com/felipecosta09/java-goof.git', branch: 'master', poll: true)
        sh 'echo \'TBD\''
      }
    }

    stage('Source Code Test') {
      steps {
        sh 'echo \'TBD\''
      }
    }

    stage('Container Build') {
      steps {
        sh 'docker build -t java-app:latest .'
      }
    }

    stage('Push to ECR') {
      steps {
        sh '''$(aws ecr get-login --no-include-email --region us-east-1)
docker tag java-app:latest 650143975734.dkr.ecr.us-east-1.amazonaws.com/java-app
docker push 650143975734.dkr.ecr.us-east-1.amazonaws.com/java-app'''
      }
    }

    stage('Cloud One Container Image Scan') {
      steps {
        sh 'echo \'TBD\''
      }
    }

    stage('Dev Tests') {
      parallel {
        stage('Dev Tests') {
          steps {
            sh 'echo \'TBD\''
          }
        }

        stage('Unit Tests') {
          steps {
            sh 'echo \'TBD\''
          }
        }

        stage('Deploy Tests') {
          steps {
            sh 'echo \'TBD\''
          }
        }

      }
    }

    stage('Deploy') {
      steps {
        sh 'echo \'TBD\''
      }
    }

  }
}