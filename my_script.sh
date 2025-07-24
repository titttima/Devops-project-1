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
    agent any

    stages {
        stage('Compile') {
            steps {
                build job: 'compile-job'
            }
        }

        stage('Test') {
            steps {
                build job: 'test-job'
            }
        }

        stage('Package') {
            steps {
                build job: 'package-job'
            }
        }
    }
}
#set master agent node script in pipeline
pipeline {
    agent { label 'agent1' }

    stages {
        stage('Compile') {
            steps {
                echo 'Compiling...'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing...'
            }
        }
        stage('Package') {
            steps {
                echo 'Packaging...'
            }
        }
    }
}
