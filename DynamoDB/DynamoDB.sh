#!/bin/bash



[ DynamoDB ]

aws dynamodb help

aws dynamodb create-table help



[ Tables ]

aws dynamodb create-table \
--table-name Music \
--key-schema AttributeName=Artist,KeyType=HASH AttributeName=SongTitle,KeyType=RANGE \
--attribute-definitions AttributeName=Artist,AttributeType=S AttributeName=SongTitle,AttributeType=S \
--provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5

aws dynamodb describe-table --table-name Music

aws dynamodb put-item --table-name Music --item '{
  "Artist": {"S": "music"},  
  "AlbumTitle": {"S": "myalbum"},
  "SongTitle": {"S": "mymusic"} }'

aws dynamodb scan --table-name Music



[ Query ]

aws dynamodb scan --table-name Music
