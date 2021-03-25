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

Print "Extract payment code" "rm -rf /home/roboshop/payment && cd /home/roboshop && unzip /tmp/payment.zip && mv payment-main payment"
rm -rf /home/roboshop/payment && cd /home/roboshop && unzip /tmp/payment.zip && mv payment-main payment
Stat $?

Print "Installing Python Dependencies"
cd /home/roboshop/payment && pip3 install -r requirements.txt
Stat $?

Print "Update User details" "USER_ID=${id-u roboshop} GROUP_ID=$(id -g roboshop)
sed -i -e "/^uid/ c uid=${USER_ID}" -e "/^gid/ c gid=${GROUP_ID}" /home/roboshop/payment/payment.ini"
USER_ID=$(id -u roboshop)
GROUP_ID=$(id -g roboshop)
sed -i -e "/^uid/ c uid=${USER_ID}" -e "/^gid/ c gid=${GROUP_ID}" /home/roboshop/payment/payment.ini

Print "Update SystemD Script for Payment"
sed -i -e "s/CARTHOST/cart-ss.samdevops.tk/" -e "s/USERHOST/user-ss.samdevops.tk/" -e "s/AMQPHOST/rabbitmq-ss.samdevops.tk/" /home/roboshop/payment/systemd.service
Stat $?

Print "mv /home/roboshop/payment/systemd.service /etc/systemd/system/payment.service && systemctl daemon-reload && systemctl enable payment && systemctl start payment"
mv /home/roboshop/payment/systemd.service /etc/systemd/system/payment.service && systemctl daemon-reload && systemctl enable payment && systemctl start payment
Stat $?
