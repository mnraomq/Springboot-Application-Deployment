pipeline {
    agent any

    environment {
        PATH = "/opt/homebrew/bin:$PATH"
    }

    stages {
        stage('Print echo messages') {
            steps {
                echo "Running pipeline for branch: ${env.BRANCH_NAME}"
            }
        }

        stage('GitHub Checkout') {
            steps {
                git branch: "${env.BRANCH_NAME}", credentialsId: 'github-jenkins', url: 'https://github.com/mnraomq/Springboot-Application-Deployment.git'
            }
        }

        stage('Verify Maven path and version') {
            steps {
                sh 'echo $PATH'
                sh 'which mvn'
                sh 'mvn --version'
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
            when {
                anyOf {
                    branch 'feature*'
                    branch 'develop'
                    branch 'release'
                    branch 'hotfix'
                    branch 'main'
                }
            }
            steps {
                sh 'mvn verify -P integration-tests'
            }
        }

        stage('Maven E2E Tests') {
            when {
                anyOf {
                    branch 'release'
                    branch 'hotfix'
                    branch 'main'
                }
            }
            steps {
                sh 'mvn verify -P e2e-tests'
            }
        }

        stage('Maven Build') {
            steps {
                sh 'mvn clean install'
            }
        }

        stage('Deploy to Development') {
            when {
                branch 'develop'
            }
            steps {
                echo "Deployed my springboot application to Development environment successfully"
            }
        }

        stage('Deploy to Staging') {
            when {
                branch 'release'
            }
            steps {
                echo "Deployed my springboot application to Staging environment successfully"
            }
        }

        stage('Deploy to Production') {
            when {
                branch 'main'
            }
            steps {
                echo "Deployed my springboot application to Production environment successfully"
            }
        }
    }
}
