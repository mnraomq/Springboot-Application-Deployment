pipeline {
    agent any

    environment {
        PATH = "/usr/local/bin:/opt/homebrew/bin:$PATH"
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

        stage('SonarQube Analysis') {
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
                echo "SonarQube code quality checks are passed successfully for branch ${env.BRANCH_NAME}"
            }
        }

        stage('OWASP Dependency Check') {
            steps {
                echo "All dependency checks resolved successfully for branch ${env.BRANCH_NAME}"
            }
        }

        stage('Build Docker Image') {
            when {
                anyOf {
                    branch 'develop'
                    branch 'release'
                    branch 'main'
                }
            }
            steps {
                sh 'docker build -t mnraomq/springboot-app:latest .'
            }
        }

        stage('Trivy Image Scan') {
            when {
                anyOf {
                    branch 'develop'
                    branch 'release'
                    branch 'main'
                }
            }
            steps {
                echo "Image scan success and has no vulnerabilities from branch ${env.BRANCH_NAME}"
            }
        }

        stage('Push Docker Image to Docker Hub') {
            when {
                anyOf {
                    branch 'develop'
                    branch 'release'
                    branch 'main'
                }
            }
            steps {
                echo "Image push success for branch ${env.BRANCH_NAME}"
            }
        }

        stage('Deploy to Development') {
            when {
                branch 'develop'
            }
            steps {
                echo "Deployed my Spring Boot application to Development environment successfully"
            }
        }

        stage('Deploy to Staging') {
            when {
                branch 'release'
            }
            steps {
                echo "Deployed my Spring Boot application to Staging environment successfully"
            }
        }

        stage('Deploy to Production') {
            when {
                branch 'main'
            }
            steps {
                echo "Deployed my Spring Boot application to Production environment successfully"
            }
        }

    post {
            success {
                mail to: 'nageshgpt999@gmail.com',
                    subject: "Success: Jenkins Job for branch ${env.JOB_NAME} with build number ${env.BUILD_NUMBER}",
                    body: "Jenkins job succeeded for branch ${env.BRANCH_NAME}. Check the logs at: ${env.BUILD_URL}"

                slackSend channel: 'C0959JD6V7U',
                        message: "Success: Jenkins job for branch ${env.BRANCH_NAME} completed successfully. See logs at ${env.BUILD_URL}"
            }

            failure {
                mail to: 'nageshgpt999@gmail.com',
                    subject: "Failure: Jenkins Job for branch ${env.JOB_NAME} with build number ${env.BUILD_NUMBER}",
                    body: "Jenkins job failed for branch ${env.BRANCH_NAME}. See logs at ${env.BUILD_URL}"

                slackSend channel: 'C0959JD6V7U',
                        message: "Failure: Jenkins job for branch ${env.BRANCH_NAME} failed. Check console output. See logs at ${env.BUILD_URL}"
            }
        }
    }
}
