#!/bin/bash 

echo "Destroying stack"
aws cloudformation delete-stack --stack-name toy-cdk

echo "Deleting leftover docker images"
docker container rm aws-cdk-dind-py-lambda_runner_1
for i in `docker image list|awk '{print $1}'|grep cdk`; do docker image rm $i; done


echo "Removing relevant assets from staging bucket"
CDK_OUT=/tmp/toy-cdk/cdk.out
staging_bucket=`aws cloudformation describe-stack-resources --stack-name CDKToolkit --logical-resource-id StagingBucket --query 'StackResources[].PhysicalResourceId' --output=text`
for asset in `aws s3 ls ${staging_bucket}/assets/|awk '{print $4}'`; do
  aws s3 rm s3://${staging_bucket}/assets/${asset}
done

echo "Removing cdk.out"
rm -rf ${CDK_OUT}
mkdir -p ${CDK_OUT}


