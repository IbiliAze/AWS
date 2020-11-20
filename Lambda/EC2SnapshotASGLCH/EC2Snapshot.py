mport json
import boto3

asg = boto3.client('autoscaling')

def lambda_handler(event, context):
    instance_id = event['detail']['EC2InstanceId']
    ec2 = boto3.resource('ec2')
    instance = ec2.Instance(instance_id)
    for volume in instance.volumes.all():
        volume_id = volume.id
        snapshot = ec2.create_snapshot(
            VolumeId = volume_id
        )
        snapshot_id = snapshot.id
        print(f"Created an EBS Snapshot for Instance {instance_id}")
    
    response = asg.complete_lifecycle_action(
        LifecycleHookName = event['detail']['LifecycleHookName'],
        AutoScalingGroupName = event['detail']['AutoScalingGroupName'],
        LifecycleActionToken = event['detail']['LifecycleActionToken'],
        LifecycleActionResult = 'CONTINUE',
        InstanceId = instance_id
    )
    return {
        'statusCode': 200,
        'body': instance_id
    }

