#!/bin/bash
TODO: setup gunicorn

source .env

# # step 1
# echo "----------------------------------------------------------------"
# echo "CREATE USER DEPLOYER"
# echo "----------------------------------------------------------------"
# sshpass -p $SERVERPASSWORDS ssh -o StrictHostKeyChecking=no -l $SERVERUSERNAMES $HOSTS "bash -s" < ./user/create.sh $REMOTEACCOUNT $REMOTEPASSWORD

# # step 2 upgrade Ubuntu packages
# echo "----------------------------------------------------------------"
# echo "UPDATE SERVER"
# echo "----------------------------------------------------------------"
# sshpass -p $SERVERPASSWORDS ssh -l $SERVERUSERNAMES $HOSTS "bash -s" < ./ubuntu/installDependencies.sh

# # step 3 Install Selected Language and packages
# echo "----------------------------------------------------------------"
# echo "INSTALL PROJECT LANGUAGE"
# echo "----------------------------------------------------------------"
# if [ "$LANGUAGE" = "PHP" ]
#     then
#         echo "DJANGO FRAMEWORK DOES NOT WITH PHP. PLEASE UPDATE .ENV"
#         exit
# elif [ "$LANGUAGE" = "Python" ]
#     then
#         sshpass -p $SERVERPASSWORDS ssh -l $SERVERUSERNAMES $HOSTS "bash -s" < python/$VERSION/install.sh
# fi

# # step 4 Install Database
# echo "----------------------------------------------------------------"
# echo "INSTALL DATABASE"
# echo "----------------------------------------------------------------"
# if [ "$DB_TYPE" = "PostgreSQL" ]
#     then
#         sshpass -p $SERVERPASSWORDS ssh -l $SERVERUSERNAMES $HOSTS "bash -s" < database/postgresql/install.sh $DB_USERNAME $DB_PASSWORD $DB_DATABASE
# elif [ "$DB_TYPE" = "MySQL" ]
#     then
#         sshpass -p $SERVERPASSWORDS ssh -l $SERVERUSERNAMES $HOSTS "bash -s" < database/mysql/install.sh $DB_USERNAME $REMOTEACCOUNT $DB_DATABASE
# fi

# step 5 Install WebServer
echo "----------------------------------------------------------------"
echo "INSTALL WEBSERVER"
echo "----------------------------------------------------------------"
if [ "$WEBSERVER" = "nginx" ]
    then
        sshpass -p $SERVERPASSWORDS ssh -l $SERVERUSERNAMES $HOSTS "bash -s" < web_server/Django/nginx/install.sh $LANGUAGE $VERSION
        # step 5.1 delete existing nginx conf
        sshpass -p $SERVERPASSWORDS ssh -l $SERVERUSERNAMES $HOSTS "rm /etc/nginx/sites-available/*"
        # step 5.2 copy nginx conf
        sshpass -p ${SERVERPASSWORDS} scp "web_server/Django/nginx/conf/django" ${SERVERUSERNAMES}@${HOSTS}:/etc/nginx/sites-available/${APP_NAME}
        # step 5.3 update nginx conf
        sshpass -p $SERVERPASSWORDS ssh -l $SERVERUSERNAMES $HOSTS "bash -s" < web_server/Django/nginx/update_conf.sh $APP_NAME $HOSTS $VERSION $DEPLOY_PATH
elif [ "$WEBSERVER" = "apache" ]
    then
        sshpass -p $SERVERPASSWORDS ssh -l $SERVERUSERNAMES $HOSTS "bash -s" < web_server/Django/apache/install.sh $LANGUAGE $VERSION
        # step 5.1 delete existing nginx conf
        sshpass -p $SERVERPASSWORDS ssh -l $SERVERUSERNAMES $HOSTS "rm /etc/apache2/sites-available/*"
        # step 5.2 copy nginx conf
        sshpass -p ${SERVERPASSWORDS} scp "web_server/Django/apache/conf/django" ${SERVERUSERNAMES}@${HOSTS}:/etc/apache/sites-available/${APP_NAME}
        # step 5.3 update nginx conf
        sshpass -p $SERVERPASSWORDS ssh -l $SERVERUSERNAMES $HOSTS "bash -s" < web_server/Django/apache/update_conf.sh $APP_NAME $HOSTS $VERSION $DEPLOY_PATH
fi

# # step 6 Install framework
# echo "----------------------------------------------------------------"
# echo "INSTALL FRAMEWORK"
# echo "----------------------------------------------------------------"
# sshpass -p $SERVERPASSWORDS ssh -l $SERVERUSERNAMES $HOSTS "bash -s" < framework/Django/install.sh

# # # step 8 install nodejs and npm
# echo "----------------------------------------------------------------"
# echo "INSTALL NODEJS"
# echo "----------------------------------------------------------------"
# if [ "$NODEJS" = "YES" ]
#     then
#         sshpass -p $SERVERPASSWORDS ssh -l $SERVERUSERNAMES $HOSTS "bash -s" < nodejs/$NODEJS_VERSION/install.sh $DEPLOY_PATH $APP_NAME $REMOTEACCOUNT
# fi


# # step 7 create desired folder
# echo "----------------------------------------------------------------"
# echo "CREATE TARGET FOLDER"
# echo "----------------------------------------------------------------"
# sshpass -p $SERVERPASSWORDS ssh -l $SERVERUSERNAMES $HOSTS "bash -s" < git/create_folder.sh $DEPLOY_PATH $APP_NAME $REMOTEACCOUNT

# # step 7.1 clone from git repo
# echo "----------------------------------------------------------------"
# echo "CLONE REPO"
# echo "----------------------------------------------------------------"
# sshpass -p $REMOTEPASSWORD ssh -l $REMOTEACCOUNT $HOSTS "bash -s" < git/clone_project.sh $GIT_URL $DEPLOY_PATH $APP_NAME $BRANCH

# # step 8 install project dependencies
# echo "----------------------------------------------------------------"
# echo "INSTALL PROJECT DEPENDENCIES"
# echo "----------------------------------------------------------------"
# sshpass -p $REMOTEPASSWORD ssh -l $REMOTEACCOUNT $HOSTS "bash -s" < project_dep/django/install.sh "${DEPLOY_PATH}/${APP_NAME}" $NODEJS
