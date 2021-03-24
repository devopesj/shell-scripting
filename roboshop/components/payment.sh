#!/bin/bash

COMPONENT=payment

source components/common.sh

Print "Install Python" "yum install python36 gcc python3-devel -y"
yum install python36 gcc python3-devel -y
Stat $?

Print "Create User"
id roboshop || useradd roboshop
Stat$?

Print "Download The Repo"
cd /home/roboshop
curl -s -L -o /tmp/payment.zip "https://github.com/roboshop-devops-project/payment/archive/main.zip"
Stat $?

Print "Extract payment code"
rm -rf /home/roboshop/payment && cd /home/roboshop && unzip /tmp/payment.zip && mv payment-main payment && cd payment && unzip /tmp/payment.zip
Stat $?

Print "Install the dependencies"
cd /home/roboshop/payment && pip3 install -r requirements.txt
Stat $?

Print "Update SystemD Script for payment" 'sed -i -e "s/CARTENDPOINT/cart-ss.samdevops.tk/" -e "s/DBHOST/mysql-ss.samdevops.tk/" /home/roboshop/payment/systemd.service'
sed -i -e "s/CARTENDPOINT/cart-ss.samdevops.tk/" -e "s/DBHOST/mysql-ss.samdevops.tk/" /home/roboshop/payment/systemd.service
Stat $?

chown roboshop:roboshop /home/roboshop -R

Print "Copy Service Files And Start The Service"
mv /home/roboshop/payment/systemd.service /etc/systemd/system/payment.service
systemctl daemon-reload
systemctl start payment
systemctl enable payment
Stat $?