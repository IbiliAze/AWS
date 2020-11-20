import json
import os

class CloudFormation:


    def ec2(self, 
            instance_name, 
            security_group_protocol='tcp',  
            security_group_source_port='22', 
            security_group_dest_port='22', 
            security_group_cidr='0.0.0.0/0', 
            instance_type='t2.micro', 
            ami='ami-09d95fab7fff3776c',
            output_public_ip=True):

        json_payload = {
            "AWSTemplateFormatVersion": "2010-09-09",

            "Description": f"{instance_name} EC2 Description",

            "Parameters": {
                "KeyName":{
                    "Description": 'SSH Key Pair',
                    'Type': 'AWS::EC2::KeyPair::KeyName',
                    'ConstraintDescription': 'Must be the name of an existing SSH Key Pair'
                },
                'InstanceType': {
                    'Description': 'EC2 Instance Type',
                    'Type': 'String',
                    'Default': instance_type,
                    'AllowedValues': [
                        instance_type,
                        't2.nano'
                    ]
                }
            },

            "Resources": {
                instance_name: {
                    'Type': 'AWS::EC2::Instance',
                    'Properties': {
                        'InstanceType': { 'Ref': 'InstanceType' },
                        'ImageId': ami,
                        'KeyName': { "Ref" : "KeyName" },
                        'Tags': [
                            {
                                'Key': 'Name',
                                'Value': f'{instance_name} CloudFormation Template'
                            }
                        ],
                        'UserData': {'Fn::Base64': {'Fn::Join' :['', [
                            '#!/bin/bash',
                            'yum update -y',
                            'yum install httpd',
                            'cd /var/www/html',
                            'echo hello > index.html',
                            'chkconfig httpd on', 
                            'service http start'
                        ]]}}
                    }
                },
                f'{instance_name}SecurityGroup': {
                    'Type': 'AWS::EC2::SecurityGroup',
                    'Properties': {
                        'GroupDescription': 'Enable SSH via TCP port 22',
                        'SecurityGroupIngress':{
                            'IpProtocol': security_group_protocol,
                            'FromPort': security_group_source_port,
                            'ToPort': security_group_dest_port,
                            'CidrIp': security_group_cidr
                        }
                    }
                }
            },

            'Outputs': {
                'InstanceID':{
                    'Description': f'{instance_name} ID',
                    'Value': { "Ref" : instance_name }
                },
                'InstanceAZ':{
                    'Description': f'{instance_name} AZ',
                    'Value': {
                        'Fn::GetAtt': [
                            instance_name,
                            'AvailabilityZone'
                        ]
                    }
                },
                'InstancePublicIp':{
                    'Description': f'{instance_name} public IP Address',
                    'Value': {
                        'Fn::GetAtt': [
                            instance_name,
                            'PublicIp'
                        ] 
                    }
                }
            }
        }

        with open(f'AWS/templates/{instance_name}.json', 'w') as handle:
            json.dump(json_payload, handle, indent=2, sort_keys=True)


    def sam(self, output_user_data=False):
        if output_user_data == True:
            os.system('aws iam get-user')

