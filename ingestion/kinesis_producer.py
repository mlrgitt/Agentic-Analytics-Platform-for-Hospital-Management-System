import boto3, json

kinesis = boto3.client('kinesis')

kinesis.put_record(
    StreamName='appointment-stream',
    Data=json.dumps({"patient_id":"P1","doctor_id":"D1"}),
    PartitionKey="1"
)