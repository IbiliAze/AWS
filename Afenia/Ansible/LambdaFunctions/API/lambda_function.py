import json
import base64
import boto3

s3 = boto3.client("s3")

def lambda_handler(event, context):
    
    try:
        body = json.loads(event['body'])
    
        company = body['company']
        site = body['site']
        configFile = body['configFile']
        configName = body['configName']
        jumpbox = body['jumpbox']
        
        if jumpbox == Tr:
            pass
        
        s3.put_object(Bucket = "afenia", Key=f"{company}/{site}/{configName}.txt", Body=configFile)
    
        body = {
            "message": "Successfully uploaded the Running Configuration",
            "statusCode": 200,
            "configuredDevice": configName
        }
    
        response = {
            'statusCode': 200, 
            'headers': {'Content-Type':'application/json'},
            'body': json.dumps(body)
        }
        return response
    
    except Exception as e:
        print(e)

