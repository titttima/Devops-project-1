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

