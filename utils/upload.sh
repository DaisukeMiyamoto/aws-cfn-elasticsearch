#!/bin/bash

aws s3 cp ./template/cognito.yaml s3://midaisuk-public-templates/aws-cfn-elasticsearch/cognito.yaml
aws s3 cp ./template/es.yaml s3://midaisuk-public-templates/aws-cfn-elasticsearch/es.yaml
