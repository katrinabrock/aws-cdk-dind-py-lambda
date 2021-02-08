This project is non-working.

**UPDATE:** Resolved AWS aws-cdk issue number #12536  This stack works locally (on OS X). Still trying to sort out the docker in docker part.

Created in an attempt to repro or solve https://github.com/aws/aws-cdk/issues/12536 Many people are posting on the issue both success and failure with various versions of node/cdk/archiver. Wanted to find a definitely working combo isolated in docker env.

Unfortunately, hit this issue: https://github.com/aws/aws-cdk/issues/8799 first.

```
docker build -t local/cdk-test .
docker-compose up
```

