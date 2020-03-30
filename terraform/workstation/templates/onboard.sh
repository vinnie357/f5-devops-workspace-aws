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

echo "=====done====="
exit