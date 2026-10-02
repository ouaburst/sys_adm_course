#!/usr/bin/env bash

linebreak() {
	echo
	for i in {1..36}; do printf '='; done
	echo
}

display_info() {
	echo -e "\n$1"
}

display_disk() {
	printf "$(df -h --output=used / | tail -n 1 | tr -d ' ')"
	printf '/'
	printf "$(df -h --output=size / | tail -n 1 | tr -d ' ')"
}

linebreak

printf '\nSystem Information Report\n'

linebreak

display_info "hostname:\t$(hostname)"
display_info "date:\t\t$(date +%F)"
display_info "kernel:\t\t$(uname -r)"
display_info "memory:\t\t$(free -h | awk '/Mem:/ {print $3 "/" $2}')"
display_info "disk:\t\t$(display_disk)"
display_info "IP address:\t$(hostname -I | sed 's/ /, /g; s/, $//')"
display_info "gateway:\t$(ip route | awk '/default/ {print $3; exit}')"
display_info "DNS:\t\t$(resolvectl status | awk '/DNS Servers:/ {print $3; exit}')"

linebreak
