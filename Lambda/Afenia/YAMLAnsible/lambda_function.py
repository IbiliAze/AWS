import json
import boto3
import yaml

s3 = boto3.client('s3')

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

def lambda_handler(event, context):
    commands_file = event['Records'][0]['s3']['object']['key']
    arn = event['Records'][0]['s3']['bucket']['arn']
    bucket = event['Records'][0]['s3']['bucket']['name']
    commands_py = obtain_commands(bucket=bucket, file_name=commands_file, save_as=f"/tmp/{commands_file}")
    commands_to_ansible(commands_py)
    
def obtain_commands(bucket, file_name, save_as):
    s3.download_file(bucket, file_name, save_as)
    commands_js = open(save_as, "r")
    commands_py = json.load(commands_js)
    return commands_py
    
def commands_to_ansible(commands_py):
    for command in commands_py:
        ansible_tempalte_json[0]['tasks'][0]["ios_command"]['commands'].append(command)
    # print(json.dumps(ansible_tempalte_json, indent=2))
    ansible_playbook = yaml.dump(ansible_tempalte_json)
    print(ansible_playbook)
