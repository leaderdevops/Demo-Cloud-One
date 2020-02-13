pipeline {
  agent any
  stages {
    stage('Git Checkout') {
      parallel {
        stage('Git Checkout') {
          steps {
            git(url: 'https://github.com/felipecosta09/DSSC.git', branch: 'master', poll: true)
          }
        }

        stage('Static Code Analysis') {
          steps {
            sleep 5
          }
        }

      }
    }

    stage('Container Build') {
      steps {
        sh 'docker build -t web-app:latest .'
      }
    }

    stage('Push to ECR') {
      steps {
        sh '''aws --version
$(aws ecr get-login --no-include-email --region us-east-1)
docker tag web-app:latest 650143975734.dkr.ecr.us-east-1.amazonaws.com/web-app
docker push 650143975734.dkr.ecr.us-east-1.amazonaws.com/web-app'''
      }
    }

    stage('Cloud One Container Image Scan') {
      agent any
      environment {
        HIGH = '1'
      }
      steps {
        script {
           $FLAG = sh([ script: 'python /home/scAPI.py', returnStdout: true ]).trim()
           if ($FLAG == '1') {
             sh 'docker tag <your_smartcheck_ecr_name> <your_blessed_ecr_name>'
             docker.withRegistry('<https://your.ecr.domain.amazonws.com>', 'ecr:<ecr_region>:<credential_id>') {
               docker.image('<your_blessed_ecr_name>').push(env.IMAGETAG+'-'+env.BUILD_ID) }
             }
               sh 'docker rmi $(docker images -q) -f 2> /dev/null'
             }
      }
    }

    stage('Dev Tests') {
      parallel {
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

        stage('Manual Test') {
          steps {
            input 'Approve?'
          }
        }

      }
    }

    stage('Deploy') {
      steps {
        echo 'Deploy New Container to Fargate'
      }
    }

    stage('Slack Notification') {
      steps {
        slackSend(channel: '#aws-account-alerts', color: 'good', message: "*${currentBuild.currentResult}:* Job ${env.JOB_NAME} build ${env.BUILD_NUMBER}\n More info at: ${env.BUILD_URL}")
      }
    }

  }
}
