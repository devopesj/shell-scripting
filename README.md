# shell-scripting

1. She-Bang & Comments
2. Print
3. Variables 
4. Inputs
5. Re-directors ( >, <), Exit Status, Quotes
6. Functions
7. Conditions
8. Loops
9. SED command

#Scripts will end with .sh or type of scripting language used
1. Bourne shell - .sh
2. Korn Shell - .ksh
3. C Shell - .csh
4. Z Shell - . zsh

# We are learning Bash Shell
5. Bourne Again shell - .bash

Bash is default in all enterprise Linux OS (redhat, ubuntu, suse)

In Redhat, sh and bash are the same.

That's why even for bash we are giving an extension of .sh


_____________

Scripts can be exectued wit hthe interpreter directly

sh 02-print.sh 

NOTE: Assume the script has a she-bang and the above method of executing the script will override the she-bangs interpreter

or we can provide executable permission and then execute it
chmond ugo+x 02-print.sh
chmod +x 02-print.sh

./02-print.sh