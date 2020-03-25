pipeline {
  tools{
  maven 'default'
  }
  agent any
  parameters {
    gitParameter branchFilter: 'origin/(.*)', defaultValue: 'master', name: 'BRANCH', type: 'PT_BRANCH'
    choice(name: 'version', choices: ['snapshot', 'release', 'artifact'], description: 'snapshot to build')
    }
  environment {
    registry           = "deeksha17/java"
    registryCredential = 'docker-hub'
    dockerImage        = ''
  }
  stages {
    stage('Checkout code') {
      steps{
        dir ("${env.WORKSPACE}"){
          git branch: "${params.BRANCH}", changelog: false, poll: false, url:'https://github.com/dksha17/java_war.git'
        }
      }
    }
    stage('Build') {
      steps{
        dir ("${env.WORKSPACE}"){
          sh 'mvn -B -DskipTests -Denv=${env} clean package'
        }
      }
    }
    stage('publish to artifactory') {
            steps {
                dir ("${env.WORKSPACE}"){
                   sh 'mvn clean install deploy:deploy -P ${version}'
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
