This project is a proof of concept for

- running aws-cdk in docker
- using python language aws-cdk
- deploying python lambda using 


The stack works locally on Mac OS X with exact same versions of node/cdk/crc32-stream/archive. However, when attempting with docker in docker, I am still hitting this issue https://github.com/aws/aws-cdk/issues/12536.

Scripts are adapted from this repo: https://github.com/iliapolo/aws-cdk-issue12536

**Important**: Running this will deploy a stack using your local AWS credentials without asking for confirmation.

```
mkdir -p /tmp/toy-cdk/cdk.out

docker-compose up
```

`wipe.sh` (run outside docker) clears out the problematic assets both locally and from s3. Beware, it removes all assets in the staging container.

Learnings from this exercise:
- (see [this post](https://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci/)
- Limitation: cdk.out must have the same path on host and docker container. https://github.com/aws/aws-cdk/issues/8799
