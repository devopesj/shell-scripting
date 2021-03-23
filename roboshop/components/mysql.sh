#!/bin/bash

COMPONENT=mysql

source components/common.sh

Print "Setup MySQL" "'[mysql57-community] name=MySQL 5.7 Community Server baseurl=http://repo.mysql.com/yum/mysql-5.7-community/el/7/$basearch/ enabled=1 gpgcheck=0' > /etc/yum.repos.d/mysql.repo"
echo '[mysql57-community]
name=MySQL 5.7 Community Server
baseurl=http://repo.mysql.com/yum/mysql-5.7-community/el/7/$basearch/
enabled=1
gpgcheck=0' >/etc/yum.repos.d/mysql.repo
Stat $?

Print "Install MySQL" "yum remove mariadb-libs -y && yum install mysql-community-server -y"
yum remove mariadb-libs -y && yum install mysql-community-server -y
Stat $?

Print "Start MySQL"
systemctl enable mysqld && systemctl start mysqld
Stat$?

echo "show databases;" | mysql -uroot -ppassword &>/dev/null
if [ $? -ne 0 ]; then
  Print "Grab Default SQL password generated for log file"
  DEFAULT_PASSWORD=$(grep 'temporary password' /var/log/mysqld.log) | awk '{print $NF}'
  Stat $?

  Print "Reset MySQL Password" "mysql -u root -p"
  mysql -u root -p"${DEFAULT_PASSWORD}" <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY 'Default_Roboshop*999';
uninstall plugin validate_password;
ALTER USER 'root'@'localhost' IDENTIFIED BY 'password';
EOF
  Stat$?
fi

Print "Download Schema" "https://github.com/roboshop-devops-project/mysql/archive/main.zip"
curl -s -L -o /tmp/mysql.zip "https://github.com/roboshop-devops-project/mysql/archive/main.zip"
Stat $?

Print "Load Schema"
cd /tmp
unzip mysql.zip
cd mysql-main
mysql -u -root -ppasswprd <shipping.sql
Stat$?