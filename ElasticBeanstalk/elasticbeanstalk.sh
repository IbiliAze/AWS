#!/bin/bash

pip3 install awsebcli --upgrade --user

eb init --profile user

eb init

eb create

eb create --single #create a signle instance without load balancers

eb create dev-env #create a development environment

eb status

eb health

eb health --refresh #refresh every 10 seconds

eb logs

eb deploy #deploy a new version, also use to apply new changes from .ebextensions

eb open 

eb terminate

eb config save dev-env --cfg initial-configuration #dev-env is our environment naem, initial-configuration is the name of the config we are saving, precedence over eb deploy with .ebextensions

eb setenv MY_ENV_VAR=true #set environment variables, for the software configuration

eb config put initial-configuration #after you made changs to the saved config file, we update the config file with the put method

eb config dev-env --cfg initial-configuration #use the saved config file to update the EB environment

/opt/elasticbeanstalk/bin/get-config environment | jq #run on the ec2 instance, check if the environment variabes are mapped correctly, |jq is a json parser

/opt/elasticbeanstalk/bin/get-config optionsetings | jq 

