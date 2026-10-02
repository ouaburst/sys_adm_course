#!/bin/bash

create_backup()
{
	tar cfz $2backup_$(date +%F_%H%M).tar.gz $1
}

if [ -d $2 ] && [ -d $1 ]; then
	create_backup "$1" "$2"
	if [ -f $2backup_$(date +%F_%H%M).tar.gz ]; then
		echo "Success"
		logger "Backup succeeded"
		exit 0
	fi
else
	echo "Failure"
	logger "Backup failed"
	exit 1
fi
