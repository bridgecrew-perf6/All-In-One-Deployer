#!/bin/bash

#  ----------------------------------------------------------------
# 1. read environment variables from .env and export to remote server
# 2. create deployer user
# 3. install application environment dependencies
# 4. install and config database
# 5. install web server
# 6. install framework
# 7. install nodejs and npm
# 8. clone project from repository
# 9. install project dependencies
#  ----------------------------------------------------------------

# TODO:
# ----------------------------------------------------------------
# 1. auto add ssh key from server into git repo
# ----------------------------------------------------------------


# step 1. get config from user
./get_env_from_user.sh
source .env

# step 2
echo "Create user deployer"
sshpass -p $SERVERPASSWORDS ssh -o StrictHostKeyChecking=no -l $SERVERUSERNAMES $HOSTS "bash -s" < ./user/create.sh $REMOTEACCOUNT $REMOTEPASSWORD

# step 3.1 upgrade Ubuntu packages
echo "Update server"
sshpass -p $SERVERPASSWORDS ssh -l $SERVERUSERNAMES $HOSTS "bash -s" < installDependencies.sh

# step 3.2 Install Selected Language packages
echo "Install project language"
if [ "$LANGUAGE" = "PHP" ]
    then
        sshpass -p $SERVERPASSWORDS ssh -l $SERVERUSERNAMES $HOSTS "bash -s" < php/$VERSION/install.sh
elif [ "$LANGUAGE" = "Python" ]
    then
        sshpass -p $SERVERPASSWORDS ssh -l $SERVERUSERNAMES $HOSTS "bash -s" < python/$VERSION/install.sh
fi

# step 4 Install Database
echo "Install Database"
if [ "$DB_TYPE" = "PostgreSQL" ]
    then
        sshpass -p $SERVERPASSWORDS ssh -l $SERVERUSERNAMES $HOSTS "bash -s" < database/postgresql/install.sh $DB_USERNAME $DB_PASSWORD $DB_DATABASE
elif [ "$DB_TYPE" = "MySQL" ]
    then
        sshpass -p $SERVERPASSWORDS ssh -l $SERVERUSERNAMES $HOSTS "bash -s" < database/mysql/install.sh $DB_USERNAME $REMOTEACCOUNT $DB_DATABASE
fi

# step 5 Install WebServer
if [ "$WEBSERVER" = "nginx" ]
    then
        sshpass -p $SERVERPASSWORDS ssh -l $SERVERUSERNAMES $HOSTS "bash -s" < web_server/nginx/install.sh $LANGUAGE $VERSION
        # step 5.1 delete existing nginx conf
        sshpass -p $SERVERPASSWORDS ssh -l $SERVERUSERNAMES $HOSTS "rm /etc/nginx/sites-available/*"
        # step 5.2 copy nginx conf
        sshpass -p ${SERVERPASSWORDS} scp "web_server/nginx/conf/laravel" ${SERVERUSERNAMES}@${HOSTS}:/etc/nginx/sites-available/${APP_NAME}
        # step 5.3 update nginx conf
        sshpass -p $SERVERPASSWORDS ssh -l $SERVERUSERNAMES $HOSTS "bash -s" < web_server/nginx/update_conf.sh $APP_NAME $HOSTS $VERSION $DEPLOY_PATH
elif [ "$WEBSERVER" = "apache" ]
    then
        sshpass -p $SERVERPASSWORDS ssh -l $SERVERUSERNAMES $HOSTS "bash -s" < web_server/apache/install.sh $LANGUAGE $VERSION
        # step 5.1 delete existing nginx conf
        sshpass -p $SERVERPASSWORDS ssh -l $SERVERUSERNAMES $HOSTS "rm /etc/apache2/sites-available/*"
        # step 5.2 copy nginx conf
        sshpass -p ${SERVERPASSWORDS} scp "web_server/apache/conf/laravel" ${SERVERUSERNAMES}@${HOSTS}:/etc/apache/sites-available/${APP_NAME}
        # step 5.3 update nginx conf
        sshpass -p $SERVERPASSWORDS ssh -l $SERVERUSERNAMES $HOSTS "bash -s" < web_server/apache/update_conf.sh $APP_NAME $HOSTS $VERSION $DEPLOY_PATH
fi

# step 6 Install framework
if [ "$FRAMEWORK" = "Laravel" ]
    then
        sshpass -p $SERVERPASSWORDS ssh -l $SERVERUSERNAMES $HOSTS "bash -s" < framework/Laravel/install.sh
elif [ "$FRAMEWORK" = "Django" ]
    then
        sshpass -p $SERVERPASSWORDS ssh -l $SERVERUSERNAMES $HOSTS "bash -s" < framework/Django/install.sh
fi

# # step 8 install nodejs and npm
if [ "$NODEJS" = "YES" ]
    then
        sshpass -p $SERVERPASSWORDS ssh -l $SERVERUSERNAMES $HOSTS "bash -s" < nodejs/$NODEJS_VERSION/install.sh $DEPLOY_PATH $APP_NAME $REMOTEACCOUNT
fi


# step 7 create desired folder
sshpass -p $SERVERPASSWORDS ssh -l $SERVERUSERNAMES $HOSTS "bash -s" < git/create_folder.sh $DEPLOY_PATH $APP_NAME $REMOTEACCOUNT

# step 7.1 clone from git repo
sshpass -p $REMOTEPASSWORD ssh -l $REMOTEACCOUNT $HOSTS "bash -s" < git/clone_project.sh $GIT_URL $DEPLOY_PATH $APP_NAME $BRANCH

# step 8 install project dependencies
sshpass -p $REMOTEPASSWORD ssh -l $REMOTEACCOUNT $HOSTS "bash -s" < project_dep/laravel/install.sh "${DEPLOY_PATH}/${APP_NAME}" $NODEJS

# SCRIPT="pwd; ls -al"
# for HOSTNAME in ${HOSTS} ; do
#     echo ${HOSTNAME[i]}
#     # create deployer account
#     # sshpass -p ${SERVERPASSWORDS[i]} ssh -l ${SERVERUSERNAMES[i]} ${HOSTNAME[i]} "bash -s" < addUser.sh ${REMOTEACCOUNT} ${REMOTEPASSWORD}
#     # sshpass -p ${SERVERPASSWORDS[i]} ssh -l ${SERVERUSERNAMES[i]} ${HOSTNAME[i]} "bash -s" < installDependencies.sh ${REMOTEACCOUNT} ${REMOTEPASSWORD} ${project} ${dbuser} ${dbpass} ${dbname}
#     # sshpass -p ${SERVERPASSWORDS[i]} ssh -l ${SERVERUSERNAMES[i]} ${HOSTNAME[i]} "${SCRIPT}"
# done