pipeline {
  agent any
  stages {
    stage('Git Checkout') {
      steps {
        git(url: 'https://github.com/felipecosta09/DSSC.git', branch: 'master')
      }
    }

    stage('Docker Build') {
      steps {
        sh 'docker build -t java-app:latest .'
      }
    }

    stage('Push to ECR') {
      steps {
        sh '''$(aws ecr get-login --no-include-email --region us-east-1)
docker tag java-app:latest 650143975734.dkr.ecr.us-east-1.amazonaws.com/java-app:latest
docker push 650143975734.dkr.ecr.us-east-1.amazonaws.com/dssc:latest'''
      }
    }

    stage('Cloud One Container Image Scan') {
      steps {
        sh 'echo \'TBD\''
      }
    }

    stage('Deploy') {
      steps {
        sh 'sudo aws s3 ls'
      }
    }

  }
}