#!/bin/bash
show_system()
{
	echo "System Information Report"
	echo " "
	echo "hostname: $(hostname)"
	echo "Kernel: $(uname -r)"
}
show_memory()
{
	echo "Memory: $(free -h)"
}
show_storage()
{
	echo "Disk: $(df -h)"
}
show_system
show_memory
show_storage
echo "IP Address: $(hostname -I)"
echo "Gateway: $(ip route | grep default)"
echo "DNS: $(resolvectl status | grep 'Current DNS Server')"
