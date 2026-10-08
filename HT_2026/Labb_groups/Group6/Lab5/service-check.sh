#!/bin/bash

check_service() {
	if [[ $active == *"active (running"* ]]; then
		return 0
	else
		return 1
	fi
}

list=$(systemctl list-units --type=service --all | grep "$1")
active=$(systemctl status $1 | grep "active (running)")

if [[ $list == *"$1"* ]]; then
	check_service
	if [ $? -eq 0 ]; then
		echo "Success"
		logger "Service is running"
	else
		systemctl restart $1
		check_service
		sleep 1
		if [ $? -eq 0 ]; then
			echo "Reactivation succeeded!"
			logger "Service is running again"
		fi
	fi
else
	echo "Service doesn't exist"
fi
