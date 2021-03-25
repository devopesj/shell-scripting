#!/bin/bash

COMPONENT=frontend-payment

source components/common.sh

Print "Change payment service"
sed -i -e "s/localhost/payment-ss.samdevops.tk" /etc/nginx/default.d/roboshop.conf

Print "Restarting Nginx Service" "systemctl restart nginx"
systemctl restart nginx
Stat $?