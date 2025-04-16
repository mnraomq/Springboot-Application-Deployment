pipeline {
    agent any

    tools {
        maven 'Maven3'
        jdk 'jdk17'
    }

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-creds')
        KUBE_CONFIG = credentials('kubeconfig-creds')
    }

    stages {
        stage("Print echo message") {
            steps {
                echo "Hello, This is my Jenkins pipeline"
            }
        }

        stage("GitHub Checkout") {
            steps {
                git branch: 'main', credentialsId: 'github-jenkins', url: 'https://github.com/mnraomq/Springboot-Application-Deployment.git'
            }
        }

        stage("Maven Compile") {
            steps {
                sh 'mvn clean compile'
            }
        }

        stage("Maven Unit Tests") {
            steps {
                sh 'mvn test'
            }
        }

        stage("Maven Integration Tests") {
            steps {
                sh 'mvn verify -P integration-tests'
            }
        }

        stage("Maven E2E Tests") {
            steps {
                sh 'mvn verify -P e2e-tests'
            }
        }

        stage("Maven Build") {
            steps {
                sh 'mvn clean install'
            }
        }

        stage("Docker Build and Push") {
            steps {
                script {
                    sh 'docker build -t mnraomq/springboot-application .'
                    sh 'docker login -u ${DOCKERHUB_CREDENTIALS_USR} -p '
                    sh 'docker push mnraomq/springboot-application'
                }
            }
        }

        stage("deploy to kubernetes") {
            steps {
                withCredentials([file(credentialsId: 'kubeconfig-creds', variable: 'KUBECONFIG')]) {
                    sh 'kubectl apply -f deployment.yml'
                    sh 'kubectl apply -f service.yml'
                }
            }
        }
    }
}
