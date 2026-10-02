#!/bin/bash

service=$1

log_message()
{
    logger -t lab5 "$1"
}

#Check if service exists, exit the script if it does not.
does_service_exist()
{
    local result=$(systemctl status "$1" 2>&1)
    if [[ $result == *"could not be found"* ]]; then
	echo -e "ERROR: Service $1 does not exist."
	log_message "ERROR: Service $1 does not exist."
	exit 1
    fi
}

#Check status of given service. Returns 0 if its active, 1 if its inactive.
check_service()
{
    if systemctl is-active --quiet "$service"; then
       	echo -e "$service service is running"
	log_message "$service is running"
	return 0
    else 
       	echo -e "$service service is not running"
	log_message "$service is not running"
	return 1
    fi
}

#Attempts to restart the given service once, then checks if it was succesful. 
restart_service()
{
    if systemctl restart "$service"
		echo -e "$service service is restarting"
		log_message "$service service is restarting"
		sleep 2; then
		#check if program has restarted
		check_service "$service"
    fi
}


does_service_exist "$service" 
if ! check_service "$service"; then
	restart_service "$service"
fi

