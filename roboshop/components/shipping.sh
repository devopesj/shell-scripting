#!/bin/bash

COMPONENT=shipping

source components/shipping.sh

Print "Install Maven"
yum install maven -y
Stat $?

Print "Create User"
id roboshop || useradd roboshop
Stat$?

Print "Download The Repo"
cd /home/roboshop
curl -s -L -o /tmp/shipping.zip "https://github.com/roboshop-devops-project/shipping/archive/main.zip"
unzip /tmp/shipping.zip && mv shipping-main shipping && cd shipping && mvn clean package && mv target/shipping-1.0.jar shipping.jar
Stat $?

Print "Copy Service Files And Start The Service"
cp /home/roboshop/shipping/systemd.service /etc/systemd/system/shipping.service
systemctl daemon-reload
systemctl start shipping
systemctl enable shipping
