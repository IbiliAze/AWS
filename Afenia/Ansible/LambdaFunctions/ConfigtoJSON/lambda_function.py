import json
import boto3
import os

s3 = boto3.client('s3')

def lambda_handler(event, context):
    running_config = event['Records'][0]['s3']['object']['key']
    arn = event['Records'][0]['s3']['bucket']['arn']
    bucket = event['Records'][0]['s3']['bucket']['name']
    
    commands_py = config_to_dict(bucket=bucket, file_name=running_config, save_as="/tmp/config.txt")
    convert_to_json(commands_py=commands_py, file_name=running_config)
    
def config_to_dict(bucket, file_name, save_as):
    s3.download_file(bucket, file_name, save_as)
    running_config_file = open(save_as, "r")
    commands_py = []
    for line in running_config_file:
        stripped_line = line.strip()
        if stripped_line != '!':
            print(stripped_line)
            commands_py.append(stripped_line)
    return commands_py
    os.remove(save_as)

def convert_to_json(commands_py, file_name):
    commands_js = json.dumps(commands_py, indent=2)
    
    file_name_clean = file_name.replace('.txt', '.json')

    running_config_json = open("/tmp/config.json", "a")
    running_config_json.write(commands_js)
    running_config_json.close()
    
    s3.upload_file("/tmp/config.json", 'afeniadestination', f"{file_name_clean}")
    
    os.remove("/tmp/config.json")
