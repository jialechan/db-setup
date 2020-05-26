#!/bin/bash

# setup kubectl
sudo curl --silent --location -o /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
sudo chmod +x /usr/local/bin/kubectl
sudo yum -y install jq gettext bash-completion
kubectl completion bash >>  ~/.bash_completion
. /etc/profile.d/bash_completion.sh
. ~/.bash_completion

# update cdk
npm install -g npm
npm install -g aws-cdk --force

# install cdk8s
npm install -g cdk8s-cli

# aws启动自动完成
echo 'export PATH=/usr/local/bin:$PATH' >> ~/.bash_profile
source ~/.bash_profile
complete -C '/usr/local/bin/' aws

# 生成aws默认region
echo 'export AWS_DEFAULT_REGION=`curl -s http://169.254.169.254/latest/dynamic/instance-identity/document | jq .region -r`' >> ~/.bash_profile

# 生成cdk环境
echo 'export CDK_DEFAULT_ACCOUNT=`aws sts get-caller-identity | jq .Account -r`' >> ~/.bash_profile
echo 'export CDK_DEFAULT_REGION=`curl -s http://169.254.169.254/latest/dynamic/instance-identity/document | jq .region -r`' >> ~/.bash_profile
source ~/.bash_profile