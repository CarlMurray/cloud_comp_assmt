#!/bin/bash
# Installs AWS CLI
# Gets AWS access keys from AWS Systems Manager Parameter Store
# Sets as env vars in EC2 instance

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
AWS_ACCESS_KEY=$(aws ssm get-parameter --name ACCESS_KEY --region eu-west-1 --with-decryption --query Parameter.Value)
AWS_SECRET_ACCESS_KEY=$(aws ssm get-parameter --name SECRET_ACCESS_KEY --region eu-west-1 --with-decryption --query Parameter.Value)
echo "AWS_ACCESS_KEY=$AWS_ACCESS_KEY" >>/etc/environment
echo "AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY" >>/etc/environment
echo "AWS_REGION=eu-west-1" >>/etc/environment
source /etc/environment
