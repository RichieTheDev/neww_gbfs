import json
import requests
import boto3
import logging
import os
from datetime import datetime, timedelta

logger = logging.getLogger()
logger.setLevel(logging.INFO)

s3 = boto3.client('s3')
sns = boto3.client('sns')
cloudwatch = boto3.client('cloudwatch')

def load_providers(bucket_name, key):
    obj = s3.get_object(Bucket=bucket_name, Key=key)
    providers = json.loads(obj['Body'].read().decode('utf-8'))
    return providers

def calculate_trends(vehicle_counts):
    # Calculate percentage change between consecutive days
    trends = []
    for i in range(1, len(vehicle_counts)):
        previous_count = vehicle_counts[i-1]['vehicle_count']
        current_count = vehicle_counts[i]['vehicle_count']
        percentage_change = ((current_count - previous_count) / previous_count) * 100
        trends.append({
            'date': vehicle_counts[i]['date'],
            'percentage_change': percentage_change
        })
    return trends

def lambda_handler(event, context):
    try:
        bucket_name = os.environ['S3_BUCKET_NAME']
        sns_topic_arn = os.environ['SNS_TOPIC_ARN']
        providers = load_providers(bucket_name=bucket_name, key='providers.json')
        
        for provider in providers:
            provider_name = provider['name']
            provider_url = provider['url']
            
            response = requests.get(provider_url)
            data = response.json()
            
            vehicle_count = len(data.get('data', {}).get('stations', []))
            
            # Store in S3
            file_name = f"data/{provider_name}-{datetime.now().isoformat()}.json"
            s3.put_object(Bucket=bucket_name, Key=file_name, Body=json.dumps(data))
            
            # Store vehicle count with timestamp
            vehicle_counts = s3.get_object(Bucket=bucket_name, Key='vehicle_counts.json')
            vehicle_counts = json.loads(vehicle_counts['Body'].read().decode('utf-8'))
            vehicle_counts.append({
                'provider': provider_name,
                'date': datetime.now().strftime('%Y-%m-%d'),
                'vehicle_count': vehicle_count
            })
            s3.put_object(Bucket=bucket_name, Key='vehicle_counts.json', Body=json.dumps(vehicle_counts))
            
            # Calculate trends
            trends = calculate_trends(vehicle_counts)
            
            # Store trends in S3
            trends_file = f"data/{provider_name}_trends.json"
            s3.put_object(Bucket=bucket_name, Key=trends_file, Body=json.dumps(trends))
            
            # Publish CloudWatch metric
            cloudwatch.put_metric_data(
                Namespace='GBFS/VehicleCount',
                MetricData=[
                    {
                        'MetricName': 'VehicleCount',
                        'Dimensions': [
                            {
                                'Name': 'Provider',
                                'Value': provider_name
                            },
                        ],
                        'Value': vehicle_count,
                        'Unit': 'Count'
                    },
                ]
            )
            
            sns.publish(
                TopicArn=sns_topic_arn,
                Message=f'Provider: {provider_name}, Vehicles: {vehicle_count}, Trends: {trends[-1] if trends else "N/A"}'
            )

        return {
            'statusCode': 200,
            'body': json.dumps('Processing completed successfully')
        }
    except Exception as e:
        logger.error(f'Error: {str(e)}')
        raise e
