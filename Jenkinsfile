pipeline {
    agent { label 'build-server' }

    environment {
        DOCKER_IMAGE = "toumaa/abcproject:1.0"
        CONTAINER_NAME = "abc-container"
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/titttima/Devops-project-1.git'
            }
        }

        stage('Compile') {
            steps {
                sh '''
                  set -e
                  cd ABC_Technologies
                  mvn -B clean compile
                '''
            }
        }

        stage('Test') {
            steps {
                sh '''
                  set -e
                  cd ABC_Technologies
                  mvn -B test
                '''
            }
        }

        stage('Package WAR') {
            steps {
                sh '''
                  set -e
                  cd ABC_Technologies
                  mvn -B package
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                  set -e
                  cp ABC_Technologies/target/ABCtechnologies-1.0.war .
                  docker build -t $DOCKER_IMAGE .
                '''
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-credentials',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh '''
                      echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                      docker push $DOCKER_IMAGE
                    '''
                }
            }
        }

        stage('Deploy to Kubernetes via Ansible') {
            steps {
                dir('ansible-docker-deploy/playbooks') {
                    sh 'ansible-playbook deploy_k8s.yaml'
                }
            }
        }
    }
}

