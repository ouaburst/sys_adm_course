#!/bin/bash

service=$1


log_message()
{
    logger -t lab5 "$1"
}


does_service_exist()
{
    local result=$(systemctl status $1 2>&1)
    if [[ $result == *"could not be found"* ]]; then
	echo -e "ERROR: Service $1 does not exist."
	log_message "ERROR: Service $1 does not exist."
	exit 1
    fi
}

check_service()
{
    if systemctl is-active --quiet $service; then
       	echo -e "$service service is running"
	log_message "$service is running"
	return 0
    else 
       	echo -e "$service service is not running"
	log_message "$service is not running"
	return 1
    fi
}

restart_service()
{
    if systemctl restart $service
	echo -e "$service service is restarting"
	log_message "$service is restarting"
	sleep 2; then
	#check if program has restarted
	check_service "$service"
    fi
}


does_service_exist "$1" 
if ! check_service "$1"; then
	restart_service "$1"
fi

