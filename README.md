# aws-cfn-elasticsearch
CloudFormation template for Elasticsearch service with Cognito authentication on AWS

## Overview

```
-> Firehose -> Elasticsearch service -> Kibana <- Cognito
            -> S3
```

## Set up

### Cognito for Kibana Auth

```bash
aws cloudformation create-stack \
    --stack-name KibanaCognito \
    --template-body file://cognito.yaml \
    --capabilities CAPABILITY_IAM \
    --region ap-northeast-1

aws cognito-idp create-user-pool-domain \
    --user-pool-id {USER_POOL_ID} \
    --domain {IPD_USER_POOL_DOMAIN_NAME} \
    --region ap-northeast-1
```

- add user for cognito user pool

### LogManager

```bash
aws cloudformation create-stack \
    --stack-name LogManager \
    --template-body file://logmanager.yaml \
    --parameters \
        ParameterKey=LogBucketName,ParameterValue={BUCKET_NAME} \
        ParameterKey=ElasticsearchDomainName,ParameterValue={ES_DOMAIN_NAME} \
        ParameterKey=ElasticsearchIndexName,ParameterValue={ES_INDEX_NAME} \
        ParameterKey=FirehoseName,ParameterValue={FIREHOSE_NAME} \
    --capabilities CAPABILITY_NAMED_IAM \
    --region ap-northeast-1

aws es update-elasticsearch-domain-config \
    --domain-name {ES_DOMAIN_NAME} \
    --cognito-options Enabled=true,UserPoolId="{USER_POOL_ID}",IdentityPoolId="{ID_POOL_ID}",RoleArn="{COGNITO_SERVICE_ROLE}" \
    --region ap-northeast-1
```
