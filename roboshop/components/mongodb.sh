#!/bin/bash

COMPONENT=mongodb

source components/common.sh

Print "\e[32mISetup MongoDB Repo\e[0m" ""
echo '[mongodb-org-4.2]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/4.2/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.2.asc' >/etc/yum.repos.d/mongodb.repo
Stat $?

Print "Installing and starting MongoDB"
yum install -y mongodb-org
systemctl enable mongod
systemctl start mongod
Stat $?

Print "Update MongoDB Config" "sed"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
Stat $?

Print "Restart MongoDB service"
systemctl restart mongod
Every Database needs the schema to be loaded for the application to work.
Download the schema and load it.

Print "Download MongoDB Schema" "curl -s -L -o /tmp/mongodb.zip "https://github.com/roboshop-devops-project/mongodb/archive/main.zip""
curl -s -L -o /tmp/mongodb.zip "https://github.com/roboshop-devops-project/mongodb/archive/main.zip"
Stat $?

Print "Load Schema" "cd /tmp && unzip mongodb.zip && && cd mongodb-main && mongo < catalogue.js && mongo < users.js"
cd /tmp && unzip mongodb.zip && cd mongodb-main && mongo < catalogue.js && mongo < users.js
Stat $?