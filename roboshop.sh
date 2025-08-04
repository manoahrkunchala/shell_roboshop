#!/bin/bash

AMI_ID="ami-09c813fb71547fc4f"
SG_ID="sg-0f881a0fc38c5ca29"
INSTANCES=("mongo" "catalogue" "frontend")
ZONE_ID="Z00866383QDB2Q3KMMLAX"
DOMAINE_ID="gayatriraksha.icu"

for instance in  ${INSTANCES[@]}
do 
    INSTANCE_ID=$(aws ec2 run-instances --image-id ami-09c813fb71547fc4f --instance-type t2.micro --security-group-ids sg-0f881a0fc38c5ca29 --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$instance}]" --query "Instances[0].InstanceId" --output text)
    if [ $instance != "frontend" ]
    then
        IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query "Reservations[0].Instances[0].PrivateIpAddress" --output text)
    else
        IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query "Reservations[0].Instances[0].PrivateIpAddress" --output text)
    fi
    echo "$instance IP Adress:$IP"
done