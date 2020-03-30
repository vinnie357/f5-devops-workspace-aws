#!/bin/bash
# logging
LOG_FILE=/var/log/startup-script.log
if [ ! -e $LOG_FILE ]
then
     touch $LOG_FILE
     exec &>>$LOG_FILE
else
    #if file exists, exit as only want to run once
    exit
fi

exec 1>$LOG_FILE 2>&1

# install terraform locally
# jq 
# curl
# awscli
# f5 cli
# auto complete

# ubuntu 18.04
# terraform 12.23?
# awscli
# f5 cli
# terragrunt

set -ex \
&& sudo apt-get update -y \
&& sudo apt-get install -y apt-transport-https wget unzip jq git software-properties-common python3-pip \
&& echo "terraform" \
&& sudo wget https://releases.hashicorp.com/terraform/${terraformVersion}/terraform_${terraformVersion}_linux_amd64.zip \
&& sudo unzip ./terraform_${terraformVersion}_linux_amd64.zip -d /usr/local/bin/ \
&& echo "awscli" \
&& sudo apt-get install awscli -y \
&& echo "f5 cli" \
&& pip3 install f5-cli \
&& echo "terragrunt" \
&& sudo wget https://github.com/gruntwork-io/terragrunt/releases/download/v${terragruntVersion}/terragrunt_linux_amd64 \
&& sudo mv ./terragrunt_linux_amd64 /usr/local/bin/terragrunt \
&& sudo chmod +x /usr/local/bin/terragrunt \
&& echo "chef Inspec" \
&& curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -P inspec \
&& echo "auto completion" \
&& complete -C '/usr/bin/aws_completer' aws \
&& echo 'alias f5=/home/ubuntu/.local/bin/f5' >>~/.bashrc \
&& terraform -install-autocomplete 
echo "=====done====="
exit