#!/usr/bin/env bash

# store the service status line in a variable for later processing
statusarray=($(systemctl status $1 2>&1 | head -n 3 | tail -n 1))


# exit if service does not exist
echo ${statusarray[@]} | grep "could not be found" && exit 1


# log current state of the service
echo "Unit $1.service is ${statusarray[1]}" | tee /dev/stdout | logger -t service-check


# start the service if it is inactive
[[ ${statusarray[1]} == "inactive" ]] && sudo systemctl start $1 && { echo "Unit $1.service was started" | tee /dev/stdout | logger -t service-check; }
