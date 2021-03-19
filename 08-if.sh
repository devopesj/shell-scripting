#!/bin/bash

if [ "$USER" != "root" ]; then
  echo Hey, You are not a root user
fi

read -p 'Enter your Name: ' name

if [ -z "$name"]; then
  echo Hey, you have not entered your name
fi

if [ -z "$a"]; then
  echo Variables a is empty
else
  echo Variable a is not empty. It is "${a}".
#To unset variable command - "unset (variable)"
fi
