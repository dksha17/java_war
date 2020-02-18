pipeline {
  options {
    ansiColor('xterm')
  }   
  environment {
    registry           = "deeksha17/java"
    registryCredential = 'docker-hub'
    dockerImage        = ''
  }
  agent any
  stages {
    stage('Checkout code') {
      steps{
        dir ("${env.WORKSPACE}/app"){
          git branch: "master", changelog: false, poll: false, url:'https://github.com/dksha17/java_war.git'
        }
      }
    }
    stage('Build') {
      steps{
        dir ("${env.WORKSPACE}"){
          sh 'mvn -B clean package'
        }
      }
    }
    stage('publish to artifactory') {
            steps {
                dir ("${env.WORKSPACE}"){
                   sh 'mvn clean install deploy:deploy -P release'
                }  
            }
        }
    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build(registry , "-f Dockerfile .")
        }
      }
    }
    
    stage('push Image to acr') {
      steps{
        script {
          docker.withRegistry( '', registryCredential ) {
          dockerImage.push()
          }
        }
      }
    }
  }
}
