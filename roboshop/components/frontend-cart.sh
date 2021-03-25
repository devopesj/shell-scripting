#!/bin/bash

COMPONENT=frontend-cart

source components/common.sh

Print "Change cart service"
sed -i -e "s/localhost/cart-ss.samdevops.tk" /etc/nginx/default.d/roboshop.conf
Stat $?

Print "Restarting Nginx Service" "systemctl restart nginx"
systemctl restart nginx
Stat $?