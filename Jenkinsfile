pipeline {
    agent any

    triggers {
        githubPush()
    }

    stages {
        stage("Print echo message") {
            steps {
                echo "Hello, This is my jenkins pipeline"
            }
        }
        stage("github checkout") {
            steps {
                git branch: 'main', credentialsId: 'github-jenkins', url: 'https://github.com/mnraomq/Springboot-Application-Deployment.git'
            }
        }
        stage("maven compile") {
            steps {
                sh 'mvn clean compile'
            }
        }
        stage("maven run unit tests") {
            steps {
                sh 'mvn clean test'
            }
        }
        stage("maven integration tests") {
            steps {
                sh 'mvn verify -e intergation-tests'
            }
        }
        stage("maven end to end tests") {
            steps {
                sh 'mvn verify -e end-to-end-tests'
            }
        }
        stage("maven build with compiled code") {
            steps {
                sh 'mvn clean install'
            }
        }
        stage("docker image creation with artifact file") {
            steps {
                sh 'docker build -t mnraomq/springboot-application .'
                withCredentials(credentialsId: ' ', variable: ' ') {
                    sh "docker login -u mnraomq -p (password)"
                    sh 'docker push mnraomq/springboot-appilication'
                }
            }
        }
        stage("deploy to kubernetes") {
            steps {
                withCredentials(credentialsId: ' ', variable: ' ') {
                    sh 'kubectl apply -f deployment.yml'
                    sh 'kubectl apply -f service.yml'
                }
            }
        }
    }
}
