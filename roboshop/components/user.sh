#!/bin/bash

COMPONENT=user

source components/common.sh

Print "Installing NodeJS" "yum install nodejs make gcc-c++ -y"
yum install nodejs make gcc-c++ -y
Stat $?

Print "Adding RoboShop Project User" "useradd roboshop"
id roboshop || useradd roboshop
Stat $?

Print "Download user Component Code" 'curl -s -L -o /tmp/user.zip "https://github.com/roboshop-devops-project/user/archive/main.zip"'
curl -s -L -o /tmp/user.zip https://github.com/roboshop-devops-project/user/archive/main.zip
Stat $?

Print  "Extract user Component Code" "rm -rf /home/roboshop/user && cd /home/roboshop && unzip /tmp/user.zip && mv user-main user && cd /home/roboshop/user"
rm -rf /home/roboshop/user && cd /home/roboshop && unzip /tmp/user.zip && mv user-main user && cd /home/roboshop/user
Stat $?

Print "Install NOdeJS Dependencies" "npm install"
npm install --unsafe-perm
Stat $?

chown roboshop:roboshop /home/roboshop -R

Print "Update SystemD Script for user" "s/MONGO_DNSNAME/mongodb-ss.samdevopsb.tk/' /home/roboshop/user/systemd.service && mv /home/roboshop/user/systemd.service /etc/systemd/system/user.service"
sed -i -e 's/MONGO_ENDPOINT/mongodb-ss.samdevops.tk/' -e 's/REDIS_ENDPOINT/redis-ss.samdevopsb.tk/' /home/roboshop/user/systemd.service && mv /home/roboshop/user/systemd.service /etc/systemd/system/user.service
Stat $?

Print "Start user Service" "systemctl daemon-reload && systemctl restart user && systemctl enable user"
systemctl daemon-reload && systemctl restart user && systemctl enable user
Stat $?
