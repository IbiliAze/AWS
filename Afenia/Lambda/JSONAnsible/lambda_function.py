import json
import yaml
import boto3
import os

s3 = boto3.client('s3')

def lambda_handler(event, context):
    file_name = event['Records'][0]['s3']['object']['key']
    arn = event['Records'][0]['s3']['bucket']['arn']
    bucket = event['Records'][0]['s3']['bucket']['name']
    commands_py = obtain_commands(bucket=bucket, file_name=file_name, save_as=f"/tmp/config.json")
    ansible_playbook = commands_to_ansible(commands_py)
    save_to_repo(code = ansible_playbook, file_name=file_name)
    print(file_name)
    
def obtain_commands(bucket, file_name, save_as):
    s3.download_file(bucket, file_name, save_as)
    commands_js = open(save_as, "r")
    commands_py = json.load(commands_js)
    os.remove(save_as)
    return commands_py
    
def commands_to_ansible(commands_py):
    ansible_tempalte_json = [
      {
        "name": "AWS Playbook",
        "hosts": "r1",
        "tasks": [
          {
            "name": "Commands",
            "ios_command": {
              "commands": []
            },
            "register": "output"
          },
          {
            "name": "make sure a directory exists",
            "file": {
              "path": "outputs",
              "state": "directory"
            },
            "run_once": True,
            "delegate_to": "localhost"
          }
        ]
      }
    ]
  
    for command in commands_py:
        ansible_tempalte_json[0]['tasks'][0]["ios_command"]['commands'].append(command)
    # print(json.dumps(ansible_tempalte_json, indent=2))
    ansible_playbook = yaml.dump(ansible_tempalte_json)
    # print(ansible_playbook)
    return ansible_playbook

def save_to_repo(code, file_name):
  
    file_name_adjusted = file_name.replace(".json", '.yaml')
  
    ansible_playbook_file = open("/tmp/config.yaml", "a")
    ansible_playbook_file.write(code)
    ansible_playbook_file.close()
    
    s3.upload_file("/tmp/config.yaml", 'afenias3repo', f"{file_name_adjusted}")
    
    os.remove("/tmp/config.yaml")
