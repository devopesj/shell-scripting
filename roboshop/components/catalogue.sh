#!/bin/bash

COMPONENT=catalogue

source components/common.sh

Print "\e[34mInstalling Nodejs\e[0m" "yum install nginx -y"
yum install nodejs make gcc-c++ -y
Stat $?

Print "Adding Roboshop project user"
id roboshop || useradd roboshop
Stat $?

Print "Download Catalogue Component Code" '"curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip"'
curl -s -L -o /tmp/catalogue.zip https://github.com/roboshop-devops-project/catalogue/archive/main.zip
Stat $?

Print "Extract Catalogue Component Code" "rm -rf /home/roboshop/catalogue && mkdir -p /home/roboshop/catalogue && cd /home/roboshop/catalogue && unzip /tmp/catalogue.zip"
rm -rf /home/roboshop/catalogue && mkdir -p /home/roboshop/catalogue && cd /home/roboshop/catalogue && unzip /tmp/catalogue.zip
Stat $?

Print "Install Nodejs Dependencies" "npm install"
npm install --unsafe perm
Stat $?

Print "Update SystemD Script for Catalogue"
sed -i -e 's/MONGO_DNSNAME/mongodb-ss.samdevops.tk/' /home/roboshop/catalogue/systemd.service && mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service
Stat $?

Print "lets set up the service with systemctl" "Start Catalogue" "systemctl daemon-reload && systemctl start catalogue && systemctl enable catalogue"
systemctl daemon-reload && systemctl start catalogue && systemctl enable catalogue
Stat $?
