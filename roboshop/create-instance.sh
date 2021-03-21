#!/bin/bash

component=$1

if [ -z "${component}" ]; then
  echo "Need to Input Component Name"
  exit 1
fi

STATE=$( aws ec2 describe-instances --filters "Name=tag:Name,Values=${component}" --query 'Reservations[*].Instances[*].State.Name' --output text)

if [ "$STATE" != "running" ]; then
  aws ec2 run-instances --launch-template LaunchTemplateId=lt-083666db45a13df5f --tag-specifications "ResourceType=instance,Tags=[{Key=Name,
   Value=${component}}]"
   sleep 20
fi

IPADDRESS=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=${component}" --query 'Reservations[*].Instances[*].PrivateIpAddress' --output text)
export component
export IPADDRESS

envsubst <record.json >/tmp/${component}.json

aws route53 change-resource-record-sets --hosted-zone-id Z01740343DEHVU707V4GH --change-batch file:///tmp/${component}.json


