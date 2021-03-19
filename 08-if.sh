#!/bin/bash

if [ "$USER" != "root" ]; then
  echo Hey, You are not a root user
fi

if [ -z "$a"]; then
  echo Variables a is empty
else
  echo Variable a is not empty. It is "${a}".
fi
