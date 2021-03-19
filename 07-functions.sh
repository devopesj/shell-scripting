#!/bin/bash

## Declare a function

# Way1
sample() {
  return 10
  a=200
  echo Hello from sample function
  echo a = $a
  b=20
  echo First Argument = $1
}

#Way2
function sample1() {
  echo Hello from sample1 function
}


## Main Program
## Access the function
a=10
sample xyz
echo Exit status of sample function = $?
sample1
b=100
echo b = $b
