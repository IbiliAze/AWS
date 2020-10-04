#!/bin/bash
sudo systemctl status amazon-ssm-agent #check if ssm agent has been installed

''' Install SSM Agent on On-Prem instances '''
mkdir /tmp/ssm
curl https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm -o /tmp/ssm/amazon-ssm-agent.rpm
sudo yum install -y /tmp/ssm/amazon-ssm-agent.rpm
sudo systemctl stop amazon-ssm-agent
sudo amazon-ssm-agent -register -code "PZom/fbS8+Y3yX0oQyFx" -id "2cbb6e51-fc4f-4711-a06a-850de453fb99" -region "us-east-1"
sudo systemctl start amazon-ssm-agent
sudo systemctl status amazon-ssm-agent




aws ssm get-parameters --names /EC2/AMI_ID /EC2/InstanceType #retrieve 2 parameters
aws ssm get-parameters --names /EC2/AMI_ID /EC2/InstanceType --with-decryption
aws ssm get-parameters-by-path --path /EC2/ #retrieve parameters under the EC2 folder
aws ssm get-parameters-by-path --path /EC2/ --recursive
aws ssm get-parameters-by-path --path /EC2/ --recursive --with-decryption
