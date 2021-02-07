#!/usr/bin/env python3

from aws_cdk import core

from toy_cdk.toy_cdk_stack import ToyCdkStack


app = core.App()
ToyCdkStack(app, "toy-cdk", env={'region': 'us-west-2'})

app.synth()
