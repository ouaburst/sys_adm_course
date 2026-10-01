#!/bin/bash
create_backup()
{
	tar -czf $destdit/backup_$timestamp.tar.gz $srcdir
}
timestamp=$(date +%Y%m%d%H%M)
srcdir=$1
destdir=$2
if [ -d $srcdir && $destdir ]; then
	create_backup
	if [ -f $destdir/backup_$timestamp.tar.gz ]; then
		logger "Successful Backup"
		exit 0
	else 
		logger "Backup Failed"
		exit 1
	fi
else 
	logger "Directory does not exist"
fi
