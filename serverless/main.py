import boto3
import json
import gzip
import os
import base64
# from botocore.vendored import requests
# from urllib.error import HTTPError, URLError
# from urllib.request import Request, urlopen
import logging
import slack_sdk
import re
from slack_sdk.webhook import WebhookClient

logger=logging.getLogger()
logger.setLevel(logging.INFO)
def lambda_handler(event,context):

    ssm = boto3.client('ssm')
    account_id = event['account']
    bucketName = event['detail']['requestParameters']['bucketName']
    eventName  = event['detail']['eventName']
    user_arn    = event['detail']['userIdentity']['arn']

    #Create format for slack message and make request to the API

    webhook_name = os.environ["SLACK_WEBHOOK_URL"]
    webhook_url = ssm.get_parameter(Name=webhook_name, WithDecryption=True)
    webhook = WebhookClient(webhook_url['Parameter']['Value'])
    try:
        response = webhook.send(
            text="fallback",
            blocks=[
                {
                    "type": "image",
                    "title": {
                        "type": "plain_text",
                        "text": "S3Notify",
                        "emoji": True
                    },
                    "image_url": "https://slack-bot-images.s3.eu-west-2.amazonaws.com/SlackBot.jpeg",
                    "alt_text": "marg"
                },
                {
                    "type": "divider"
                },
                {
                    "type": "header",
                    "text": {
                        "type": "plain_text",
                        "text": "S3 Logging Events"
                    }
                },
                {
                    "type": "divider"
                },
                {
                    "type": "section",
                    "fields": [
                        {
                            "type": "mrkdwn",
                            "text": f'*BucketName:*\n{bucketName}'
                        },
                        {
                            "type": "mrkdwn",
                            "text": f':aws:*AccountId:*\n{account_id}'
                        }
                    ]
                },
                {
                    "type": "section",
                    "fields": [
                        {
                            "type": "mrkdwn",
                            "text": f'*EventName:*\n{eventName}'
                        },
                        {
                            "type": "mrkdwn",
                            "text": f'*ChangedBy:*\n{user_arn}'
                        }
                    ]
                }
            ]
        )
    except Exception as error:
        logger.error("An error occurred while sending a cloudwatch logs to slack")
    