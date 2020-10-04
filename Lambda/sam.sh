sam --version

sam init --runtime python3.8

#BUILD
cd sam-app
sam build
sam local invoke "HelloWorldFunction" -e events/event.json #local test using docker


#TEST
sam local start-api #start API Gateway
curl http://127.0.0.1/hello #test API Gateway and Lambda integration


#PACKAGE
sam package --output-template-file packaged.yaml --s3-bucket aws-devops-ibi --region us-east-1


#DEPLOY
sam deploy --template-file packaged.yaml --capabilities CAPABILITY_IAM --stack-name aws-sam-getting-started --region us-east-1

