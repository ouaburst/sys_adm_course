#!/bin/bash

SourceDirectory=("$1")
DestinationDirectory=("$2")
Timestamp=$(date +%y-%m-%d_%s)
Filename="backup-${Timestamp}.tar.gz"
DestFile="$DestinationDirectory$Filename"

if [ ! -d "$SourceDirectory" ]; then
	echo "Source directory does not exist"
	logger -t backup "Error: Source directory does not exist"
	exit 1
fi

if [ ! -d "$DestinationDirectory" ]; then
	echo "Destination directory does not exist"
	logger -t backup "Error: Destination directory does not exist"
	exit 1
fi

logger -t backup "Backup started" 

sudo tar cfz "$DestFile" "$SourceDirectory"

if [ "$?" = 0 ]; then
	echo "Success"
	logger -t backup "Backup ok"
else
	echo "Failure"
	logger -t backup "Backup failed"
fi

logger -t backup "Backup done"
exit 0


