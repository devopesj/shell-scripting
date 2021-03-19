#!/bin/bash

echo I am common

##Validate the script is executed as a root user or not

USER_ID=$(id -u)

if [ "$USER_ID" -ne 0 ]; then
  echo -e "\e[31mYou must be a root user to execute this script\e[0m]"
fi