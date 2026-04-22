import boto3

s3 = boto3.client('s3')

s3.upload_file(
    'sample_reports.csv',
    'hospital-raw',
    'reports/sample_reports.csv'
)