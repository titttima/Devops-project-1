# Step 1: Clone the repository
touma@touma-tablet:~$ git clone git@github.com:titttima/Devops-project-1.git
Cloning into 'Devops-project-1'...
remote: Enumerating objects: 32, done.
remote: Counting objects: 100% (32/32), done.
remote: Compressing objects: 100% (21/21), done.
remote: Total 32 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
Receiving objects: 100% (32/32), 11.45 KiB | 902.00 KiB/s, done.
#!/bin/bash

# Step 2: Navigate into the correct project directory
cd Devops-project-1/"ABC Technologies"

# Step 3: Build the project using Maven
mvn clean install

# or 

cd ~/Devops-project-1/"ABC Technologies" 
/opt/maven/bin/mvn compile 
/opt/maven/bin/mvn test 
/opt/maven/bin/mvn package 
/opt/maven/bin/mvn clean install 
ls target/*.war 

java -jar jenkins.war
java -version
java -jar jenkins.war --httpPort=9090
cd ~/jenkins
wget https://get.jenkins.io/war-stable/2.452.1/jenkins.war -O jenkins.war
java -jar jenkins.war --httpPort=9090
# build first job compile source code
cd ~/Devops-project-1/"ABC Technologies"
mvn compile
#pipeline script in jenkins
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
                    sh '''
                      ansible-playbook deploy_k8s.yaml
                    '''
                }
            }
        }
    }
}
