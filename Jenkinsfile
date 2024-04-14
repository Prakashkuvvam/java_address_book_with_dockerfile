pipeline {
    agent any
    tools {
        jdk 'jdk8'
        maven 'maven3'
    }
    stages {
        stage('Git Checkout') {
            steps {
                git changelog: false, poll: false, url: 'https://github.com/Prakashkuvvam/javaaaaa.git'
            }
        }
        
        stage('Trivy FS Scan') {
            steps {
                sh 'trivy fs .'
            }
        }
        
        stage('Compile') {
            steps {
                sh 'mvn compile'
            }
        }
        
        stage('Code Review') {
            steps {
                sh 'mvn -P metrics pmd:pmd'
            }
        }
        
        stage('Unit Test') {
            steps {
                sh 'mvn test'
            }
        }
        
        stage('Package') {
            steps {
                sh 'mvn package'
            }
        }
        
        stage('Building Docker Image') {
            steps {
                sh 'docker build -t prakashkuvam/addressbook:v1 .'
            }
        }
        
        stage('Trivy Image Scan') {
            steps {
                sh ' image prakashkuvam/addressbook:v1'
            }
        }
        
        // stage('Slack Notification') {
        //     steps {
        //         slackSend botUser: true, channel: '#java-project', message: 'completed ${env.JOB_NAME} ${env.BUILD_NUMBER} ${env.BUILD_STATUS}', teamDomain: 'java-vprofile-project', tokenCredentialId: 'slack-token'
        //     }
        // }
        
    }
    
    post {
        success {
            script {
                // Send Slack notification for successful build
                def jobName = env.JOB_NAME
                def buildNumber = env.BUILD_NUMBER
                def slackMessage = "Job  ${jobName} (Build ${buildNumber}) succeeded. Good job team!"
                
                slackSend botUser: true, channel: '#java-project', message: slackMessage, teamDomain: 'java-vprofile-project', tokenCredentialId: 'slack-token'
                //slackSend(channel: '#your-slack-channel', message: slackMessage)
            }
        }
        failure {
            script {
                // Send Slack notification for failed build
                def jobName = env.JOB_NAME
                def buildNumber = env.BUILD_NUMBER
                def slackMessage = "Job  ${jobName} (Build ${buildNumber}) failed. Please investigate!"
                
                slackSend botUser: true, channel: '#java-project', message: slackMessage, teamDomain: 'java-vprofile-project', tokenCredentialId: 'slack-token'
                //slackSend(channel: '#your-slack-channel', message: slackMessage)
            }
        }
    }
    
}
