#!/bin/bash

COMPONENT=frontend-shipping

source components/common.sh

Print "Change shipping service"
sed -i -e "s/localhost/shipping-ss.samdevops.tk" /etc/nginx/default.d/roboshop.conf

Print "Restarting Nginx Service" "systemctl restart nginx"
systemctl restart nginx
Stat $?