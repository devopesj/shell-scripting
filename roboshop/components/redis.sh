#!/bin/bash

COMPONENT=redis

source components/common.sh

Print "Install Redis Repos" "yum install epel-release yum-utils http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y"
yum install epel-release yum-utils http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y
Stat $?

Print "Install Redis" "yum-config-manager --enable remi && yum install redis -y"
yum-config-manager --enable remi && yum install redis -y
Stat $?

Print "Update Redis Configuration" "sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf
Stat $?

Print "Start Redis Database" "systemctl enable redis && systemctl start redis"
systemctl enable redis && systemctl start redis
Stat $?