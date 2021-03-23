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
Stat $?

Print "Extract shipping code"
rm -rf /home/roboshop/shipping && cd /home/roboshop/shipping && unzip /tmp/shipping.zip  && mv shipping-main shipping && cd shipping
Stat $?

Print "Maven Compile Code"
mvn clean package && mv target/shipping-1.0.jar shipping.jar
Stat $?

Print "Update SystemD Script for Shipping" 'sed -i -e "s/CARTENDPOINT/cart-ss.samdevops.tk/" -e "s/DBHOST/mysql-ss.samdevops.tk/" /home/roboshop/shipping/systemd.service'
sed -i -e "s/CARTENDPOINT/cart-ss.samdevops.tk/" -e "s/DBHOST/mysql-ss.samdevops.tk/" /home/roboshop/shipping/systemd.service
Stat $?

chown roboshop:roboshop /home/roboshop -R

Print "Copy Service Files And Start The Service"
mv /home/roboshop/shipping/systemd.service /etc/systemd/system/shipping.service
systemctl daemon-reload
systemctl start shipping
systemctl enable shipping
Stat $?