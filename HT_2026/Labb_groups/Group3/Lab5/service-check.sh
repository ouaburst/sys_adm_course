#!/bin/bash

log_message(){
logger -t service-monitor "$1"
}

service=("$1")
#checks if the service exists
doesExist=$(systemctl is-enabled "$service" | grep "not-found")

#prints and reports an error if the service does not exist
if [ "$?" = 0 ]; then
	echo "The requested service does not exist"
	log_message "The requested service $service does not exist"
	log_message "Exiting with error"
	exit 1
fi

#checks if the service is active
isActive=$(systemctl status "$service" | grep "inactive")

#checks the exit status of systemctl status to dicering if it is running
if [ "$?" != 0 ]; then
	echo "The service is active"
	log_message "The requested service $service does exists and is running"
else
	echo "The service is not running. Restarting..."
	log_message "The service is not running. Restarting..."
	systemctl restart "$service"
	systemctl status "$service" | grep "inactive"
	
	if [ "$?" != 0 ]; then
		echo "Service $service is now running"
		log_message "After a restart the service $service is now running"
	else
		echo "The requested service $service cannot be restarted"
		log_message "The requested service $service cannot be restarted"
		log_message "Exiting with error"
		exit 1
	fi
fi

log_message "Exiting successfully"



