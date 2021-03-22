#!/bin/bash

COMPONENT=cart

source components/common.sh

Print "Installing NodeJS" "yum install nodejs make gcc-c++ -y"
yum install nodejs make gcc-c++ -y
Stat $?

Print "Adding RoboShop Project User" "useradd roboshop"
id roboshop || useradd roboshop
Stat $?

Print "Download cart Component Code" 'curl -s -L -o /tmp/cart.zip "https://github.com/roboshop-devops-project/cart/archive/main.zip"'
curl -s -L -o /tmp/cart.zip https://github.com/roboshop-devops-project/cart/archive/main.zip
Stat $?

Print  "Extract cart Component Code" "rm -rf /home/roboshop/cart && cd /home/roboshop && unzip /tmp/cart.zip && mv cart-main cart"
rm -rf /home/roboshop/cart && cd /home/roboshop && unzip /tmp/cart.zip && mv cart-main cart && cd /home/roboshop/cart
Stat $?

Print "Install NOdeJS Dependencies" "npm install"
npm install --unsafe-perm
Stat $?

chown roboshop:roboshop /home/roboshop -R

Print "Update SystemD Script for cart" "sed -i -e 's/REDIS_ENDPOINT/redis-ss.samdevops.tk/' /home/roboshop/cart/systemd.service && mv /home/roboshop/cart/systemd.service /etc/systemd/system/cart.service"
sed -i -e 's/REDIS_ENDPOINT/redis-ss.devops.tk/' -e 's/CATALOGUE_ENDPOINT/catalogue-ss.devops.tk/' /home/roboshop/cart/systemd.service && mv /home/roboshop/cart/systemd.service /etc/systemd/system/cart.service
Stat $?

Print "Start cart Service" "systemctl daemon-reload && systemctl restart cart && systemctl enable cart"
systemctl daemon-reload && systemctl restart cart && systemctl enable cart
Stat $?