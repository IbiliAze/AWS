#!/bin/bash

aws cludtrail --validate-logs --start-time 2015-08-27T00:00:00Z \
    --trail-arn awn:aws:cloudtrail:us-east-1:{account-number}:trail/my-trail-name --verbose 


aws cloudwatch put-metric-data --metric-name FunnyBunnymetric \
    --namespace Custom -- value 1243 \
    --dimensions InstanceId={instanceid},InstanceType=t2.micro \
    --region us-east-1 #custom metric namespace with custom output data


aws cloudwatch get-metric-statistics #api for pushing metric logs to a destination, eg. S3


''' Install the Unified CloudWatch Agent for custom Metrics and Logs '''
# download the agent
wget https://s3.amazonaws.com/amazoncloudwatch-agent/amazon_linux/amd64/latest/amazon-cloudwatch-agent.rpm
sudo rpm -U ./amazon-cloudwatch-agent.rpm
# install the agent
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-config-wizard


''' Boot an EC2 Instance from the CloudWatch Unified Agent Config file stored in SSM Parameter Store '''
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c ssm:{configuration-paramter-store-name} -s #option 1: boot from ssm, what cool kids do

sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:{configuration-file-path} -s #option 2: boot from file
''' If Failed '''
sudo mkdir -p /usr/share/collectd
sudo touch /usr/share/collectd/types.db



''' CloudWatch Logs subscription '''
aws logs put-subscription-filter \
    --log-group-name "CloudTrail" \
    --filter-name "RootAccess" \
    --filter-pattern "{$.userIdentity.type = Root}" \
    --destination-arn "arn:aws:kinesis:region:123456789012:stream/RootAccess" \
    --role-arn "arn:aws:iam::123456789012:role/CWLtoKinesisRole"
    --region us-east-1
