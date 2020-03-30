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
set -ex \
&& sudo apt-get update -y \
&& sudo apt-get install -y apt-transport-https wget unzip jq git software-properties-common \
&& sudo wget https://releases.hashicorp.com/terraform/${terraformVersion}/terraform_${terraformVersion}_linux_amd64.zip \
&& sudo unzip ./terraform_${terraformVersion}_linux_amd64.zip -d /usr/local/bin/ \
&& sudo apt-get install awscli -y \
&& complete -C '/usr/bin/aws_completer' aws \
&& terraform -install-autocomplete 

echo "=====done====="
exit