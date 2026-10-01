#!/bin/bash
service=$1
service_exists()
{
	systemctl list-units --full -all | grep -Fq "$service.service"
	if [ $? -eq 0 ]; then
		return 0
	else
		return 1
	fi
}
service_active()
{
	systemctl status $service | grep -Fq "inactive"
	if [ $? -eq 0 ]; then
		return 1
	else
		return 0
	fi
}
if service_exists; then
	if service_active; then
		echo "Service is Active"
		logger "Service is Active"
	else
		echo "Service is not active, attempting restart"
		logger "service is not active"
		systemctl start $service
		if service_active; then
			echo "Service is now restarted"
		else
			echo "Service did not restart (still inactive)"
		fi
	fi
else
	echo "Service does not exist"
fi
