#!/bin/bash

# Variable : If we assign a name to a set of data is called as Variable

# Declare a variable in bash shell
NAME=DEVOPS

# Usually other scripting languages will have data types, But shell by default will not have any data types.. All the data is a string for shell.

# Variable names can have character a-z, A-Z, 0-9, _

COUNT=2

# Access the variable  $VAR_NAME / ${VAR_NAME}

echo NAME=$NAME
echo COUNT=$COUNT

FILE1=sample.txt
FILE2=mew.txt

#cp $FILE1 $FILE2

# If your data has spaces then you have to use quotes
NAME="Welcome to DevOps"

echo "Count of Apples = ${COUNT}no"

# ----------------------

# Sometimes we need variable data dynamically

## Ex:

echo "Welcome, Good Morning, Today date is 2021-02-08"

# Above statement makes it wrong because of static date

# Command Substitution
# VAR=$(COMMAND)

DATE=$(date +%F)
echo "Welcome, Good Morning, Today date is $DATE"

## Arithmetic Substitution

ADD=$((2+3+4+5+6))
CALC=$((2+3-4*5+6*2/7))

echo ADD = $ADD

echo "Value of a = $A"

echo "Value of calc = $A"
