#!/bin/bash

COMPONENT=rabbitmq

source components/common.sh

yum list installed | grep esl-erlang
if [ $? -ne 0 ]; then
  Print "Installing Erlang Dependency"
  yum install https://github.com/rabbitmq/erlang-rpm/releases/download/v23.2.6/erlang-23.2.6-1.el7.x86_64.rpm -y
  Stat $?
fi

Print "Setup YUM Repo"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash
Stat $?

Print "Install RabbitMQ" "yum install rabbitmq-server -y "
yum install rabbitmq-server -y
Stat $?

Print "Start RabbitMQ" "systemctl enable rabbitmq-server && systemctl start rabbitmq-server"
systemctl enable rabbitmq-server && systemctl start rabbitmq-server
Stat $?

Print "Creating Application User" "add_user roboshop and roboshop123"
rabbitmqctl add_user roboshop roboshop123
rabbitmqctl set_user_tags roboshop administrator && rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"
Stat $?
