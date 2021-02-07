import json
import pytest

from aws_cdk import core
from toy-cdk.toy_cdk_stack import ToyCdkStack


def get_template():
    app = core.App()
    ToyCdkStack(app, "toy-cdk")
    return json.dumps(app.synth().get_stack("toy-cdk").template)


def test_sqs_queue_created():
    assert("AWS::SQS::Queue" in get_template())


def test_sns_topic_created():
    assert("AWS::SNS::Topic" in get_template())
