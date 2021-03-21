#!/bin/bash

component=$1

if [ -z "${component}" ]; then
  echo "Need to Input Component Name"
  exit 1
fi

aws ec2 run-instances --launch-template LaunchTemplateId=lt-083666db45a13df5f --tag-specifications "ResourceType=instance,Tags=[{Key=Name,
Value=${component}}]"