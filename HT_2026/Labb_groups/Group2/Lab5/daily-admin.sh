#!/bin/bash
#colors for the code
GREEN="\e[0;32m"
RED="\e[0;31m"
NC="\e[0m"

date=$(date +'%Y-%m-%d %H:%M:%S')

#Service array used to contain all services that will have their status controlled during runtime.
service_array=("ssh" "apache2")

#Functions
print_header()
{
	printf '%s\n' "==================="
	printf "${GREEN}The Daily-Admin ${NC}\n"
	printf '%s\n' "==================="
	printf '%s\n' "$date"
	printf '%s\n' "Hostname: $(hostname)"
}

print_disk()
{
	local disk=$(duf -only local)
	printf '%s\n' "==================="
	printf "${GREEN}DISK ${NC}\n"
	printf '%s\n' "==================="
	printf '%s\n' "$disk"
	log_message "$disk "
}

print_memory()
{
	local memory=$(free -h)
	printf '%s\n' "==================="
	printf "${GREEN}Memory ${NC}\n"
	printf '%s\n' "==================="
	printf '%s\n' "$memory"
	log_message "$memory"
}

backup_etc()
{
	printf '%s\n' "==================="
	echo "Backup process of /etc initiated."
	sudo ./backup.sh /etc ~/backup >> daily-admin.log
	backup_result=$?
	if [ $backup_result -eq 0 ]; then 
		echo "Backup of /etc to $HOME/backup was successful."
	else
		echo "Backup of /etc to $HOME/backup failed. Read $HOME/backup_errors.log for more info."
	fi
}

log_message()
{
	local current_date=$(date +'%Y-%m-%d %H:%M:%S')

	logger -t daily-admin "$1"
	echo "[$current_date] $1" >> daily-admin.log
}

check_services()
{
    printf '%s\n' "==================="
    local services=("$@")

    for service in "${services[@]}"; do
		if systemctl is-active --quiet $service; then
			printf "${GREEN}$service service is running ${NC}\n"
			log_message "Service $service is running."
		else
			printf "${RED}$service service is not running. ${NC}\n"
			log_message "Service $service is not running."
		fi
    done
}


#Script flow
print_header 
print_disk
print_memory
backup_etc
check_services "${service_array[@]}"
