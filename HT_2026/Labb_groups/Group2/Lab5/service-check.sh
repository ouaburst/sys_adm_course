#!/bin/bash

program=$1

#if systemctl is-active --quiet $1; then
#	echo -e "$1 service is running"
#	logger -t lab5 "$1 is running and logged"
#	exit 0
#elif
#	echo -e "$1 service is not running"; then
#	systemctl restart $1 
#	echo -e "$1 service is reseting"
#	sleep 2
#	systemctl is-active --quiet $1
#
#	logger -t lab5 "$1 has resrart and running"
#	exit 0
#fi



log_message()
{
logger -t lab5 "$1"
}


check_service()
{
if systemctl is-active --quiet $1; then
	echo -e "$1 service is running"
	log_message "$1 is running"
	return 0
else 
	echo -e "$1 service is not running"
	log_message "$1 is not running"
	return 1
fi
}

restart_service()
{
if systemctl restart $1
	echo -e "$1 service is restarting"
	log_message "$1 is restarting"
	sleep 2; then
	#check if program has restart
	check_service "$1"
fi
}


if ! check_service "$1"; then
	restart_service "$1"
fi

