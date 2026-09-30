date=$(date +%F)
hostname=$(hostname)
user=$(whoami)

showSystem(){
uptime=$(uptime)
kernel=$(uname -r)
cpuInfo=$(lscpu | grep -A 0 Architecture | less)
echo ""
echo "Uptime: $uptime"
echo ""
echo "Kernel running: $kernel"
echo ""
echo "Cpu $cpuInfo"
echo ""
}

showMemory(){
memory=$(free -h)
disk=$(df -h)
echo "Current memory usage: $memory"
echo ""
echo "Current disk usage: $disk"
echo ""
}

showNetwork(){
ipv4=$(hostname -I)
defaultGateway=$(ip route | grep via)
dnsServer=$(cat /etc/resolv.conf | grep nameserver)
echo "Ipv4 address: $ipv4"
echo ""
echo "Default gateway: $defaultGateway"
echo ""
echo "DNS server: $dnsServer"
}

echo "=============================================================="
echo ""
echo "System Information Report"
echo ""
echo "=============================================================="

echo ""
echo "Hostname: $hostname"
echo ""
echo "Date: $date"
echo ""
echo "User: $user"
	showSystem
	showMemory
	showNetwork
echo "=============================================================="
