#!/bin/bash

if [ -f .env ]
    then
        echo -e "Existing .env found. Press \n 1. Delete .env \n 2. Backup old env and start new env. \n 3. Use existing .env"
        read -p "Enter your choice : " existing_env
        if [ "$existing_env" = 1 ]
            then
                echo "Deleting existing .env"
                rm .env
        elif [ "$existing_env" = 2 ]
            then
                mv .env .env_old
        elif [ "$existing_env" = 3 ]
            then
                exit 0
        else
            echo "You choice is not exist"
            exit 1
        fi
fi

read -p "Enter project name : " APP_NAME
read -p "Enter remote IP or hostname : " HOSTS
read -p "Enter remote username : " SERVERUSERNAMES
read -p "Enter remote password : " SERVERPASSWORDS
read -p "Enter new deployer name : " REMOTEACCOUNT
read -p "Enter new deployer password : " REMOTEPASSWORD
echo -e "Select Database type \n 1. PostgreSQL \n 2. MySQL"
read -p "Enter database type : " DB_TYPE
read -p "Enter database username : " DB_USERNAME
read -p "Enter database password : " DB_PASSWORD
read -p "Enter database name : " DB_DATABASE

# save into .env
echo "# Project name" >> .env
echo "APP_NAME=$APP_NAME" >> .env
# echo "" >> .env
echo "# variables to connect server" >> .env
echo "HOSTS=$HOSTS" >> .env
echo "SERVERUSERNAMES=$SERVERUSERNAMES" >> .env
echo "SERVERPASSWORDS=$SERVERPASSWORDS" >> .env
# echo "" >> .env
echo "# variable for create new deployer user" >> .env
echo "REMOTEACCOUNT=$REMOTEACCOUNT" >> .env
echo "REMOTEPASSWORD=$REMOTEPASSWORD" >> .env
# echo "" >> .env
echo "# Database" >> .env
if [ "$DB_TYPE" = 1 ]
    then
        echo "DB_TYPE=PostgreSQL" >> .env
        DB_TYPE=PostgreSQL
elif [ "$existing_env" = 2 ]
    then
        echo "DB_TYPE=MySQL" >> .env
        DB_TYPE=MySQL
else
    echo "Please re-start"
fi
echo "DB_USERNAME=$DB_USERNAME" >> .env
echo "DB_PASSWORD=$DB_PASSWORD" >> .env
echo "DB_DATABASE=$DB_DATABASE" >> .env

# sshpass -p !!plisca123SSH scp export_env.sh root@188.166.187.92:/tmp/
sshpass -p ${SERVERPASSWORDS} scp .export_env.sh ${SERVERUSERNAMES}@${HOSTS}:/tmp/
# sshpass -p !!plisca123SSH ssh root@188.166.187.92 'cd /tmp; ./export_env.sh'
sshpass -p ${SERVERPASSWORDS} ssh -l ${SERVERUSERNAMES} ${HOSTS} "ls -al"
