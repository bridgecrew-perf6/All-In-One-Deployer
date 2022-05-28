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
                echo "Using existing .env"
                exit 1
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
echo -e "Select Database type: \n 1. PostgreSQL \n 2. MySQL"
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
echo -e "Select Web Server : \n 1. Nginx \n 2. Apache"
read -p "Enter your choice : " WEBSERVER
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

echo -e "Do you want to install NodeJS and npm? \n 1. Yes \n 2. No"
read -p "Enter your choice : " NODEJS
if [ "$NODEJS" = 1 ]
    then
        echo -e "Select NodeJS version? \n 1. 14 \n 2. 16 \n 3. 17 \n 4. 18"
        read -p "Enter NodeJS version : " NODEJS_VERSION
        echo "NODEJS=YES" >> .env
        echo "NODEJS_VERSION=$NODEJS_VERSION" >> .env
elif [ "$NODEJS" = 2 ]
    then
        echo "NodeJS will not installed"
else
    echo "Please re-start"
fi

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
echo "# Webserver" >> .env
if [ "$WEBSERVER" = 1 ]
    then
        echo "WEBSERVER=nginx" >> .env
elif [ "$WEBSERVER" = 2 ]
    then
        echo "WEBSERVER=apache" >> .env
else
    echo "Please re-start"
fi
echo "" >> .env
echo "# Database" >> .env
if [ "$DB_TYPE" = 1 ]
    then
        echo "DB_TYPE=PostgreSQL" >> .env
elif [ "$existing_env" = 2 ]
    then
        echo "DB_TYPE=MySQL" >> .env
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
        echo "LANGUAGE=PHP" >> .env
elif [ "$LANGUAGE" = 2 ]
    then
        echo "LANGUAGE=Python" >> .env
else
    echo "Please re-start"
fi

echo "VERSION=$VERSION" >> .env

# framework
echo "" >> .env
echo "# Framework settings" >> .env
if [ "$FRAMEWORK" = 1 ]
    then
        echo "FRAMEWORK=Laravel" >> .env
elif [ "$FRAMEWORK" = 2 ]
    then
        echo "FRAMEWORK=Django" >> .env
elif [ "$FRAMEWORK" = 3 ]
    then
        echo "FRAMEWORK=FastAPI" >> .env
elif [ "$FRAMEWORK" = 4 ]
    then
        echo "FRAMEWORK=CakePHP" >> .env
else
    echo "Please re-start"
fi

# nodejs
echo "" >> .env
echo "# NodeJS settings" >> .env
if [ "$NODEJS" = 1 ]
    then
        echo "NODEJS=YES" >> .env
        echo "NODEJS_VERSION=$NODEJS_VERSION" >> .env
elif [ "$NODEJS" = 2 ]
    then
        echo "NODEJS=NO" >> .env
else
    echo "Please re-start"
fi

# sshpass -p !!plisca123SSH scp export_env.sh root@188.166.187.92:/tmp/
sshpass -p ${SERVERPASSWORDS} scp .env ${SERVERUSERNAMES}@${HOSTS}:/tmp/
# sshpass -p !!plisca123SSH ssh root@188.166.187.92 'cd /tmp; ./export_env.sh'
