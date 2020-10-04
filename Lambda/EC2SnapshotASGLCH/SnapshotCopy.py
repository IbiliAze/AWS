mport json
import boto3

asg = boto3.client('autoscaling')

def lambda_handler(event, context):
    source_region = event['region']
    destination_region = 'us-west-2'
    snapshot_id_arn = event['detail']['snapshot_id']
    snapshot_id = snapshot_id_arn.replace(f"arn:aws:ec2::{source_region}:snapshot/", "")
    print(source_region)
    print(snapshot_id)
    ec2 = boto3.resource('ec2', region_name = destination_region)
    snapshot = ec2.Snapshot(snapshot_id)
    response = snapshot.copy(
        Description=f"{event['detail-type']} Description",
        SourceRegion=source_region,
    )
    print(f"Copied the Snapshot {snapshot_id} to {destination_region} Region")
    
