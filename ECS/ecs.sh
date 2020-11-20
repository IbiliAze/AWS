#!/bin/bash

cat /etc/ecs/ecs/config #ecs config file
docker ps #docker processes
docker logs {Id}


sudo $(aws ecr get-login --no-include-email --region us-east-1) #ecr login from local
sudo docker build -t myimage:latest . 
sudo docker tag myimage:latest 285436582846.dkr.ecr.us-east-1.amazonaws.com/myimage:latest #retag the docker image
sudo docker push 285436582846.dkr.ecr.us-east-1.amazonaws.com/myimage:latest #push to ecr, make sure the image name is the same as the ecr repo name
sudo dockerpull 285436582846.dkr.ecr.us-east-1.amazonaws.com/myimage:latest #pull from ecr repo
