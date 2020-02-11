pipeline {
 agent any
 stages {
   stage('Checkout') {
     steps {
       git 'https://github.com/felipecosta09/DSSC.git'
     }
   }
   stage('Docker build') {
     steps {
       script {
         docker.build('java-app')
       }
 
     }
   }
   stage('ECR push') {
     steps {
       script {
         docker.withRegistry('650143975734.dkr.ecr.us-east-1.amazonaws.com/dssc', 'ecr:us-east-1:650143975734') {
           docker.image('java-app').push(env.IMAGETAG+'-'+env.BUILD_ID)}
         }
 
       }
     }
     stage('Smartcheck') {
       steps {
         script {
           $FLAG = sh([ script: 'python /home/scAPI.py', returnStdout: true ]).trim()
           if ($FLAG == '1') {
             sh 'docker tag java-app 650143975734.dkr.ecr.us-east-1.amazonaws.com/dssc'
             docker.withRegistry('650143975734.dkr.ecr.us-east-1.amazonaws.com/dssc', 'ecr:us-east-1: 650143975734') {
               docker.image('650143975734.dkr.ecr.us-east-1.amazonaws.com/dssc').push(env.IMAGETAG+'-'+env.BUILD_ID) }
             }
               sh 'docker rmi $(docker images -q) -f 2> /dev/null'
             }
 
           }
         }
       }
       environment {
         IMAGETAG = 'java-goof'
         HIGH = '1'
         MEDIUM = '5'
         LOW = '5'
         NEGLIGIBLE = '5'
         UNKNOWN = '5'
         USER = 'administrator'
         PASSWORD = 'trendmicro'
       }
     }
