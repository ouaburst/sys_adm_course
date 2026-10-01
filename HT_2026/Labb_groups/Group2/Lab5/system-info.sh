#!/bin/bash

#Variables
datetime=$(date)
host=$(hostname)
current_user=$(whoami)
uptime=$(uptime -p)
kernel_version=$(uname -r)
cpu_architecture=$(uname -p)
memory_usage=$(free -h)
disk_usage=$(df -h)
ipv4_address=$(hostname -I)
default_gateway=$(ip route show default)
dns=$(resolvectl status | grep -E "DNS Servers|DNS Domain")

#Functions
show_network()
{
	echo -e "IP Address: $ipv4_address\n"
	echo -e "Default Gateway: $default_gateway\n"
	echo -e "DNS:\n$dns\n"
}

show_memory()
{
	echo -e "Memory:\n$memory_usage\n"
}

show_system()
{
	echo -e "Hostname: $host\n"
	echo -e "Uptime: $uptime\n"
	echo -e "Kernel: $kernel_version\n"
	echo -e "CPU Architecture: $cpu_architecture\n"
	echo -e "Memory:\n$memory_usage\n"
	echo -e "Disk:\n$disk_usage\n"
}

select_output()
{
	arg1="$1"
	if [ -z "$arg1" ]; then
		show_system
		show_memory
		show_network
	else
		case "$arg1" in
			system)
				show_system
				;;
			memory)
				show_memory
				;;
			network)
				show_network
				;;
			*)
				echo "Incorrect argument, please use system|memory|network."
				;;
		esac
	fi
}

print_header()
{
	echo -e "====================================\n"
	echo -e "System Information Report\n"
	echo -e "====================================\n"
}

print_footer()
{
	echo -e "====================================\n"
}


#Program flow
print_header
echo -e "Date: $datetime\n"
select_output "$1"
print_footer
