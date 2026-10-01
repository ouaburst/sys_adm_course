date=$(date +%F)
hostname=$(hostname)
user=$(whoami)

print(){
echo ""
echo "$1"
echo ""

}

showSystem(){
uptime=$(uptime)
kernel=$(uname -r)
cpuInfo=$(lscpu | grep -A 0 Architecture | less)
print "Uptime: $uptime"
print "Kernel running: $kernel"
print "Cpu $cpuInfo"
}

showMemory(){
memory=$(free -h)
disk=$(df -h)
print "Current memory usage: $memory"
print "Current disk usage: $disk"
}

showNetwork(){
ipv4=$(hostname -I)
defaultGateway=$(ip route | grep via)
dnsServer=$(cat /etc/resolv.conf | grep nameserver)
print "Ipv4 address: $ipv4"
print "Default gateway: $defaultGateway"
print "DNS server: $dnsServer"
}

echo "=============================================================="
echo ""
echo "System Information Report"
echo ""
echo "=============================================================="

print "Hostname: $hostname"
print "Date: $date"
print "User: $user"
showSystem
showMemory
showNetwork
echo "=============================================================="
