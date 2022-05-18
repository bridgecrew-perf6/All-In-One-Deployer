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

read -p "Enter project name (small letters) : " APP_NAME
read -p "Enter remote IP or hostname : " HOSTS
read -p "Enter remote username : " SERVERUSERNAMES
read -p "Enter remote password : " SERVERPASSWORDS
read -p "Enter new deployer name : " REMOTEACCOUNT
read -p "Enter new deployer password : " REMOTEPASSWORD
echo -e "Select Database type \n 1. PostgreSQL \n 2. MySQL"
read -p "Enter your choice : " DB_TYPE
if [ "$DB_TYPE" = 1 ]
    then
        echo "PostgreSQL Selected"
elif [ "$DB_TYPE" = 2 ]
    then
        echo "MySQL Selected"
else
    echo "Choice not exist. Please re-start"
    exit
fi
read -p "Enter database name : " DB_DATABASE
read -p "Enter database username : " DB_USERNAME
read -p "Enter database password : " DB_PASSWORD
read -p "Enter deploy path : " DEPLOY_PATH
read -p "Enter repository url : " GIT_URL
read -p "Enter repository branch : " BRANCH
echo -e "Select Project language \n 1. PHP \n 2. Python"
read -p "Enter your choice : " LANGUAGE
if [ "$LANGUAGE" = 1 ]
    then
        read -p "Enter PHP version : " VERSION
elif [ "$LANGUAGE" = 2 ]
    then
        read -p "Enter Python version : " VERSION
else
    echo "Choice not exist. Please re-start"
    exit
fi

echo -e "Select Project Framework \n 1. Laravel \n 2. Django \n 3. FastAPI \n 2. CakePHP"
read -p "Enter your choice : " FRAMEWORK

# save into .env
echo "# Project name" >> .env
echo "APP_NAME=$APP_NAME" >> .env
echo "" >> .env
echo "# variables to connect server" >> .env
echo "HOSTS=$HOSTS" >> .env
echo "SERVERUSERNAMES=$SERVERUSERNAMES" >> .env
echo "SERVERPASSWORDS=$SERVERPASSWORDS" >> .env
echo "" >> .env
echo "# variable for create new deployer user" >> .env
echo "REMOTEACCOUNT=$REMOTEACCOUNT" >> .env
echo "REMOTEPASSWORD=$REMOTEPASSWORD" >> .env
echo "" >> .env
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

# GIT
echo "" >> .env
echo "DEPLOY_PATH=$DEPLOY_PATH" >> .env
echo "GIT_URL=$GIT_URL" >> .env
echo "BRANCH=$BRANCH" >> .env

# language
echo "" >> .env
echo "# Language settings" >> .env
if [ "$LANGUAGE" = 1 ]
    then
        echo "PHP=1" >> .env
elif [ "$LANGUAGE" = 2 ]
    then
        echo "PYTHON=1" >> .env
else
    echo "Please re-start"
fi

echo "VERSION=$VERSION" >> .env

# framework
echo "" >> .env
echo "# Framework settings" >> .env
if [ "$FRAMEWORK" = 1 ]
    then
        echo "Laravel=1" >> .env
elif [ "$FRAMEWORK" = 2 ]
    then
        echo "Django=1" >> .env
elif [ "$FRAMEWORK" = 3 ]
    then
        echo "FastAPI=1" >> .env
elif [ "$FRAMEWORK" = 4 ]
    then
        echo "CakePHP=1" >> .env
else
    echo "Please re-start"
fi

# sshpass -p !!plisca123SSH scp export_env.sh root@188.166.187.92:/tmp/
sshpass -p ${SERVERPASSWORDS} scp .env ${SERVERUSERNAMES}@${HOSTS}:/tmp/
# sshpass -p !!plisca123SSH ssh root@188.166.187.92 'cd /tmp; ./export_env.sh'
