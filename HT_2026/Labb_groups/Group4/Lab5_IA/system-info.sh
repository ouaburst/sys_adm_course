#!/bin/bash

show_system() #prints current system information
{
	echo "Date: $(date)"
	printf "\n"
	echo "Hostname: $(hostname)"
	printf "\n"
	echo "User: $(whoami)"
	printf "\n"
	echo "Uptime: $(uptime)"
	printf "\n"
	echo "Kernel: $(uname -r)"
	printf "\n"
}

show_hardware() #prints current hardware information
{
	echo "Processor: $(lscpu | grep "Architecture")"
	printf "\n"
	echo "Memory: $(free -h)"
	printf "\n"
	echo "Disk $(df -h)"
	printf "\n"
}

show_network() #prints current network information
{
	echo "IP: $(hostname -I)"
	printf "\n"
	echo "Gateway: $(ip route | grep "default")"
	printf "\n"
	echo "DNS: $(resolvectl status | grep "Current DNS Server")"
	printf "\n"
}

echo "===================================="
printf "\n"
echo "System Infoarmtion Report"
printf "\n"
echo "===================================="
printf "\n"
show_system
show_hardware
show_network
echo "===================================="

