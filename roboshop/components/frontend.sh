#!/bin/bash

COMPONENT=frontend

source components/common.sh

Print "\e[34mInstalling Nginx\e[0m"
yum install nginx -y

Print  "\e[33mEnabling and Starting Nginx\e[0m"
exit
systemctl enable nginx
systemctl start nginx

Print "\e[36mDownloading fronend zip file\e[0m"
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"
cd /usr/share/nginx/html
rm -rf *
unzip /tmp/frontend.zip
mv frontend-main/* .
mv static/* .
rm -rf frontend-master README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf

Print "\e[35mRestaeting ngninx\e[0m"
systemctl restart nginx
