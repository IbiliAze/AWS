import json
import boto3
import yaml
import json

s3 = boto3.client('s3')

def lambda_handler(event, context):
    # print(json.dumps(event, indent=2))
    running_config = event['Records'][0]['s3']['object']['key']
    arn = event['Records'][0]['s3']['bucket']['arn']
    bucket = event['Records'][0]['s3']['bucket']['name']
    s3_path = arn + '/' + running_config
    print(running_config)
    print(s3_path)
    commands_py = config_to_dict(bucket=bucket, file_name=running_config, save_as=f"/tmp/{running_config}")
    convert_to_yaml_json(commands_py=commands_py, file_name=running_config)
    
def config_to_dict(bucket, file_name, save_as):
    s3.download_file(bucket, file_name, save_as)
    running_config_file = open(save_as, "r")
    # print(running_config.read())
    commands_py = []
    for line in running_config_file:
        stripped_line = line.strip()
        if stripped_line != '!':
            print(stripped_line)
            commands_py.append(stripped_line)
    return commands_py

def convert_to_yaml_json(commands_py, file_name):
    commands_ym = yaml.dump(commands_py)
    commands_js = json.dumps(commands_py, indent=2)

    running_config_yaml = open(f"/tmp/{file_name}_yaml.yaml", "a")
    running_config_yaml.write(commands_ym)
    running_config_yaml.close()

    running_config_json = open(f"/tmp/{file_name}_json.json", "a")
    running_config_json.write(commands_js)
    running_config_json.close()

    s3.upload_file(f"/tmp/{file_name}_yaml.yaml", 'afeniadestination', f"{file_name}_yaml.yaml")
    s3.upload_file(f"/tmp/{file_name}_json.json", 'afeniadestination', f"{file_name}_json.json")

