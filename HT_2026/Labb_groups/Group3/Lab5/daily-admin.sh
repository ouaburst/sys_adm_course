#!/bin/bash

print(){
echo ""
echo "$1"
echo ""
}

is_running(){
systemctl status "$1" | grep "inactive"
if [ "$?" = 1 ]; then
	echo "$1 is running"
	logger -t daily-admin "$1 is running"
	log "$1 is running"
else
	echo "$1 is not running"
	logger -t daily-admin "$1 is not running"
	log "$1 is not running"

fi

}

log(){
echo "$date: $1" >> "/home/student/lab5/daily-admin.log"

}

#prints an header
logger -t daily-admin "Daily admin starting..."
log "Daily admin starting..."

echo "=================================="
echo "Daily admin"
echo "=================================="

#displays the current date
date=$(date +%y-%m-%d_%H:%M:%S)
print "Current date: $date"

#displays the hostname
hostname=$(hostname)
print "Hostname: $hostname"

#are services running
for service in ssh apache2
do
	is_running "$service"
done

#displays disk space
disk=$(df -h)
print "Current disk usage is: $disk"

#print the memory usage
memory=$(free -h)
print "Current memory usage is: $memory"

#create a backup of /etc
print "Creating a backup of /etc..."
logger -t daily-admin "Creating backup of /etc"
log "Creating backup of /etc"
sudo tar cfz "/home/student/backup/backup-${date}.tar.gz" "/etc"

if [ "$?" = 0 ]; then
	print "Backup done"
	log "Backup of /etc created successfully"
	logger -t daily-admin "Backup of /etc created successfully"
	exit 0
	
else
	print "Backup failed"
	log "Backup of /etc failed exiting with error..."
	logger -t daily-admin "Backup of /etc failed exiting with error..."

	exit 1
fi
