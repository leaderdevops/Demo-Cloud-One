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
        script {
          docker build -t java-app . }
