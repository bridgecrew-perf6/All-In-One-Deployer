#!/bin/bash
# Script to add a user into Ubuntu OS
# -------------------------------------------------------------------------
# Copyright (c) 2022 Mohamad Najmuddin Yusoff
# This script is licensed under GNU GPL version 2.0 or above
# -------------------------------------------------------------------------
# -------------------------------------------------------------------------
# read -p "Enter username : " username
# read -s -p "Enter password : " password
# -------------------------------------------------------------------------
if [ $(id -u) -eq 0 ]; then
    username=$1
    password=$2
    echo "Username: ${username}"
    echo "Password: ${password}"
	egrep "^${username}" /etc/passwd >/dev/null
	if [ $? -eq 0 ]; then
		echo "${username} exists!"
		exit 1
	else
		pass=$(perl -e 'print crypt($ARGV[0], "password")' ${password})
        echo "$pass"
		useradd -m -p ${password} ${username}
		[ $? -eq 0 ] && echo "User has been added to system!" || echo "Failed to add a user!"
        echo "assign user as Sudoer"
        usermod -aG sudo ${username}
        [ $? -eq 0 ] && echo "User has been assign as sudo!" || echo "Failed to assign user as sudoer!"
        usermod -aG www-data ${username}
        [ $? -eq 0 ] && echo "Add user to group www-data!" || echo "Failed to add user into group www-data!"
	fi
else
	echo "Only root may add a user to the system"
	exit 2
fi