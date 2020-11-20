#!/bin/bash

cat /var/log/cloud-init-output.log #where logs are stored

cat /var/log/cfn-init.log #where cfn-init logs are stored

aws ssm get-parameters-by-path --path /aws/service/ami-amazon-linux-latest --query 'Parameters[].Name' #run on local machine to view all the public latest amis

