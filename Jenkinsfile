pipeline {
    agent any

    stages {
        stage('Print echo messages') {
            steps {
                echo 'Hello, This is my Jenkins pipeline'
            }
        }

        stage('GitHub Checkout') {
            steps {
                git branch: 'main', credentialsId: 'github-jenkins', url: 'https://github.com/mnraomq/Springboot-Application-Deployment.git'
            }
        }

        stage('Maven Compile') {
            steps {
                sh 'mvn clean compile'
            }
        }

        stage('Maven Unit Tests') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Maven Integration Tests') {
            steps {
                sh 'mvn verify -P integration-tests'
            }
        }

        stage('Maven E2E Tests') {
            steps {
                sh 'mvn verify -P e2e-tests'
            }
        }

        stage('Maven Build') {
            steps {
                sh 'mvn clean install'
            }
        }
    }
}
