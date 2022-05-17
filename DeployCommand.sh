#!/bin/bash

# 1. read environment variables from .env and export to remote server
# 2. create deployer user
# 3. install application environment dependencies
# 4. install and config database
# 5. install web server
# 6. install framework
# 7. clone project from repository

# step 1. get config from user
# ./get_env_from_user.sh
source .env

# # step 2
# sshpass -p $SERVERPASSWORDS ssh -l $SERVERUSERNAMES $HOSTS "bash -s" < user/create.sh $REMOTEACCOUNT $REMOTEPASSWORD

# # step 3.1 upgrade Ubuntu packages
# sshpass -p $SERVERPASSWORDS ssh -l $SERVERUSERNAMES $HOSTS "bash -s" < installDependencies.sh

# # step 3.2 Install PHP 8.1 and its dependencies
# sshpass -p $SERVERPASSWORDS ssh -l $SERVERUSERNAMES $HOSTS "bash -s" < php/8.1/php8.1.sh

# # step 4 Install postgres
# sshpass -p $SERVERPASSWORDS ssh -l $SERVERUSERNAMES $HOSTS "bash -s" < database/postgresql/install.sh $DB_USERNAME $REMOTEACCOUNT $DB_DATABASE

# # step 5 Install nginx
# sshpass -p $SERVERPASSWORDS ssh -l $SERVERUSERNAMES $HOSTS "bash -s" < web_server/nginx/install.sh

# # step 6 Install framework
# sshpass -p $SERVERPASSWORDS ssh -l $SERVERUSERNAMES $HOSTS "bash -s" < framework/Laravel/install.sh

# # step 6 create desired folder and clone
# sshpass -p $SERVERPASSWORDS ssh -l $SERVERUSERNAMES $HOSTS "bash -s" < framework/Laravel/install.sh


# SCRIPT="pwd; ls -al"
# for HOSTNAME in ${HOSTS} ; do
#     echo ${HOSTNAME[i]}
#     # create deployer account
#     # sshpass -p ${SERVERPASSWORDS[i]} ssh -l ${SERVERUSERNAMES[i]} ${HOSTNAME[i]} "bash -s" < addUser.sh ${REMOTEACCOUNT} ${REMOTEPASSWORD}
#     # sshpass -p ${SERVERPASSWORDS[i]} ssh -l ${SERVERUSERNAMES[i]} ${HOSTNAME[i]} "bash -s" < installDependencies.sh ${REMOTEACCOUNT} ${REMOTEPASSWORD} ${project} ${dbuser} ${dbpass} ${dbname}
#     # sshpass -p ${SERVERPASSWORDS[i]} ssh -l ${SERVERUSERNAMES[i]} ${HOSTNAME[i]} "${SCRIPT}"
# done