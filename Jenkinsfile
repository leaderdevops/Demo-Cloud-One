pipeline {
  agent any
  stages {
    stage('Git Checkout') {
      steps {
        sh 'echo Git Checkout from the Repository'
        git(url: 'https://github.com/felipecosta09/java-goof.git', branch: 'master', poll: true)
      }
    }

    stage('Source Code Test') {
      steps {
        snykSecurity(failOnIssues: true, projectName: 'java-goof', severity: 'medium', organisation: 'felipecosta09', monitorProjectOnBuild: true)
      }
    }

    stage('Container Build') {
      steps {
        sh '''echo Build the Docker Container
echo 
docker build -t java-app:latest .'''
      }
    }

    stage('Push to ECR') {
      steps {
        sh '''echo Logging in to Amazon ECR...
aws --version
$(aws ecr get-login --no-include-email --region us-east-1)
echo 
echo Tagging Docker Build to prepare to Push
docker tag java-app:latest 650143975734.dkr.ecr.us-east-1.amazonaws.com/java-app
echo 
echo Push the New Image to ECR
docker push 650143975734.dkr.ecr.us-east-1.amazonaws.com/java-app'''
      }
    }

    stage('Cloud One Container Image Scan') {
      steps {
        sh 'echo Container Image Scan from CLoud One'
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

    stage('DS App Protect') {
      steps {
        sh 'echo Deploy New Container to Fargate'
      }
    }

    stage('Deploy') {
      steps {
        echo 'Deploy New Container to Fargate'
      }
    }

    stage('Slack Notification') {
      steps {
        slackSend(channel: '#aws-account-alerts', baseUrl: 'https://hooks.slack.com/services/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', teamDomain: 'trend-micro-india', token: 'NjfEjrQIr05gWkAox5LtSSGt', notifyCommitters: true)
      }
    }

  }
}