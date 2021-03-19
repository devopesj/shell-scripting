#!/bin/bash

echo -e "\e[34mDownloading Nginx"
yum install nginx -y

echo -e "\e[34mEnabling and Starting Nginx"
systemctl enable nginx
systemctl start nginx

echo -e "\e[34mDownloading fronend zip file"
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"
cd /usr/share/nginx/html
rm -rf *
unzip /tmp/frontend.zip
mv frontend-main/* .
mv static/* .
rm -rf frontend-master README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf

echo -e "\e[34mRestaeting ngninx"
systemctl restart nginx
