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
