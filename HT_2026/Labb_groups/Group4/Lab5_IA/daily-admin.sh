#!/bin/bash
print_header()
{
	echo "====================================="
}
write_activity()
{
	date >> /home/ltu/lab5/daily-admin.log
	echo "Service status checked!" >> /home/ltu/lab5/daily-admin.log
	logger "Service status checked by daily-admin.sh"
}
print_header
hostname
date +%F
print_header
list=$(systemctl list-units --type=service --all)
if [[ "$list" == *"ssh"* ]] && [[ "$list" == *"apache2"* ]]; then
	for service in ssh apache2
	do
		echo "$service:"
		systemctl is-active "$service"
		write_activity
	done
fi
df -h
free -h
print_header
tar cfz /home/ltu/backup/etc.tar.gz /etc 
exit 0
