#!/bin/bash

COMPONENT=mysql

source components/common.sh

Print "Setup MySQL Repo" ""
echo '[mysql57-community]
name=MySQL 5.7 Community Server
baseurl=http://repo.mysql.com/yum/mysql-5.7-community/el/7/$basearch/
enabled=1
gpgcheck=0' > /etc/yum.repos.d/mysql.repo
Stat $?

Print "Install MySQL" "yum remove mariadb-libs -y && yum install mysql-community-server -y"
yum remove mariadb-libs -y && yum install mysql-community-server -y
Stat $?

Print "Start MySQL Server" "systemctl enable mysqld  && systemctl start mysqld"
systemctl enable mysqld
systemctl start mysqld
Stat $?

echo "show databases;" | mysql -uroot -ppassword &>/dev/null
if [ $? -ne 0 ]; then
  Print "Grab Default MySQL Password" "grep temp /var/log/mysqld.log"
  DEFAULT_PASSWORD=$(grep 'temporary password' /var/log/mysqld.log | awk '{print $NF}')
  Stat $?

  Print "Reset MySQL Password" ""
  mysql --connect-expired-password -uroot -p"${DEFAULT_PASSWORD}" <<EOF
  ALTER USER 'root'@'localhost' IDENTIFIED BY 'Default_RoboShop*999';
  uninstall plugin validate_password;
  ALTER USER 'root'@'localhost' IDENTIFIED BY 'password';
EOF
  Stat $?
fi

Print "Download Schema" 'curl -s -L -o /tmp/mysql.zip "https://dev.azure.com/DevOps-Batches/f635c088-1047-40e8-8c29-2e3b05a38010/_apis/git/repositories/2235ab8a-3229-47d9-8065-b56713ed7b28/items?path=%2F&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=master&resolveLfs=true&%24format=zip&api-version=5.0&download=true"'

curl -s -L -o /tmp/mysql.zip "https://dev.azure.com/DevOps-Batches/f635c088-1047-40e8-8c29-2e3b05a38010/_apis/git/repositories/2235ab8a-3229-47d9-8065-b56713ed7b28/items?path=%2F&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=master&resolveLfs=true&%24format=zip&api-version=5.0&download=true"
Stat $?

Print "Load Schema" "mysql <shipping.sql"
cd /tmp
unzip -o mysql.zip
mysql -uroot -ppassword <shipping.sql
Stat $?