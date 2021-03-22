#!/bin/bash

COMPONENT=catalogue

source components/common.sh

Print "Installing NodeJS" "yum install nodejs make gcc-c++ -y"
yum install nodejs make gcc-c++ -y
Stat $?

Print "Adding RoboShop Project User" "useradd roboshop"
id roboshop || useradd roboshop
Stat $?

Print "Download Catalogue Component Code" 'curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip"'

curl -s -L -o /tmp/catalogue.zip https://github.com/roboshop-devops-project/catalogue/archive/main.zip
Stat $?

Print  "Extract Catalogue Component Code" "rm -rf /home/roboshop/catalogue && cd /home/roboshop && unzip /tmp/catalogue.zip && mv catalogue-main catalogue"
rm -rf /home/roboshop/catalogue && cd /home/roboshop && unzip /tmp/catalogue.zip && mv catalogue-main catalogue && /home/roboshop/catalogue
Stat $?

Print "Install NOdeJS Dependencies" "npm install"
npm install --unsafe-perm
Stat $?

chown roboshop:roboshop /home/roboshop -R

Print "Update SystemD Script for Catalogue" "sed -i -e 's/MONGO_DNSNAME/mongodb-ss.devopsb54.tk/' /home/roboshop/catalogue/systemd.service && mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service"
sed -i -e 's/MONGO_DNSNAME/mongodb-ss.devopsb54.tk/' /home/roboshop/catalogue/systemd.service && mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service
Stat $?

Print "Start Catalogue Service" "systemctl daemon-reload && systemctl restart catalogue && systemctl enable catalogue"
systemctl daemon-reload && systemctl restart catalogue && systemctl enable catalogue
Stat $?