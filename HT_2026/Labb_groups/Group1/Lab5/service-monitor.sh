#!/usr/bin/env bash

set -x

systemctl status $1 | grep -i "could not be found"; || exit

if systemctl status $1 | grep -iq "active: active" $status; then
	echo Unit $1.service is enabled. | tee /dev/tty | logger -t service-check
else
	sudo systemctl start $1 && { echo Unit $1.service was started. | tee /dev/tty | logger -t test; }
fi
