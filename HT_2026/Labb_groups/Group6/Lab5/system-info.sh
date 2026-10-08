#!/bin/bash

hostname=$(hostname)

date=$(date)

kernel=$(uname -r)

memory=$(free -h --total | grep Total)

disk=$(lsblk -o NAME,SIZE,TYPE,MOUNTPOINTS)

ip=$(hostname -I)

gateway=$(ip route | grep default)

DNS=$(resolvectl | grep "Current DNS Server")


echo "==================================="
echo
echo "System Information Report"
echo
echo "==================================="
echo
echo "Hostname: $hostname"
echo
echo "Date: $date"
echo
echo "Kernel: $kernel"
echo
echo "Memory: $memory"
echo
echo "Disk: $disk"
echo
echo "IP Address: $ip"
echo
echo "Gateway: $gateway"
echo
echo "DNS: $DNS"
echo
echo "==================================="
