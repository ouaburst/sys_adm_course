#!/bin/bash

source_dir="$1"
destination_dir="$2"
backup_name="backup_$(date +%Y%m%d-%H%M%S).tar.gz"
date=$(date +'%Y-%m-%d %H:%M:%S')
error_log="$HOME/backup_errors.log"

logger -t backup-script "Backup process of $source_dir started."
echo "[$date] Backup process of $source_dir started."

#Verifies the given directory is already existing. If not the script will exit with code 1.
verify_dir_exists()
{
	local dir="$1"
	if [ ! -d $dir ]; then
		echo "[$date] ERROR: $dir does not exist."
        	logger -t backup-script "ERROR: $dir does not exist."
        	exit 1
	fi
}

#Verify source dir exists
verify_dir_exists $source_dir

#Verify the destination dir exists
verify_dir_exists $destination_dir

#Create compressed archive and verify success
if tar -czf "$destination_dir/$backup_name" -C "$source_dir" . 2> "$error_log"  && [ -s "$destination_dir/$backup_name" ]; then
	logger -t backup-script "SUCCESS: $backup_name created in $destination_dir"
        echo "[$date] SUCCESS: $backup_name created in $destination_dir"
	exit 0
else
	echo "Above errors occured at $date" >> $error_log
	echo "[$date] ERROR: Backup process failed. Read $error_log for more details."]
	logger -t backup-script "ERROR: Backup process failed. Check $error_log for more details."
        exit 1
fi

