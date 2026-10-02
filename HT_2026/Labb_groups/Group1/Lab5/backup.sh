#!/usr/bin/env bash

# send message to stdout and syslog
log() {
	log_message=$1

	echo $log_message
	logger -t backup $log_message
}

# send error to stdout and syslog, and exit
log_error() {
	log_message=$1

	echo $log_message >&2
	logger -t backup $log_message
	exit 1
}


error_checking() {

	# exit if user does not supply two arguments
	if [ $# -ne 2 ]; then
		echo "Script needs two arguments"
		echo -e "Usage:\n$0 source destination"
		exit 1
	fi

	# exit if source target does not exist
	if [ ! -e $1 ]; then
		log_error "Source target does not exist"
	fi

	# exit if destination directory does not exist
	if [ ! -e $2 ]; then
		log_error "Destination directory does not exist"
	fi

	# exit if destination is not a directory
	if [ ! -d $2 ]; then
		log_error "Destionation is not a directory"
	fi
}

error_checking $@


# generate filename
timestamp=$(date "+%F-%k:%M")
filename="$2/backup-$timestamp.tar.gz"


log "Starting backup of $filename"

tar -czPf $filename $1


if [ $? == "0" ]; then
	log "Backup $filename created sucessfully"
else
	log_error "Backup $filename could not be created"
fi
