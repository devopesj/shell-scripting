#!/bin/bash

# Printing can be done with two commands. 1. printf 2. echo
# We will use echo command since it is user friendly. Both do the same job

echo Hello World
echo Welcome to Devops

## When we try to print a message and if we try to grab the attention of the user then colours while printing is GREAT!

# By using ESC sequences in echp we can print colours
# \n - New line
##When we user ESC seq, Input to echo command should be given in double quotes (single quotes can also be used but preferred is double quotes)
# Also ESC seq works when you enable -e option to echo the command

echo -e "Hello,\nWelcome to Devops"