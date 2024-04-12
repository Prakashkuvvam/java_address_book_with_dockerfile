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
                sh 'trivy image prakashkuvam/addressbook:v1'
            }
        }
        
    }
}
