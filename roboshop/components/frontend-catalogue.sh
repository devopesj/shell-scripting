#!/bin/bash

COMPONENT=frontend-catalogue

source components/common.sh

Print "Change catalogue service"
sed -i -e "s/localhost/catalogue-ss.samdevops.tk" /etc/nginx/default.d/roboshop.conf

Print "Restarting Nginx Service" "systemctl restart nginx"
systemctl restart nginx
Stat $?