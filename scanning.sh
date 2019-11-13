#!/bin/bash
#to grab info
ip=$(ifconfig | grep inet | grep -v "inet6\|127.0.0.1" | awk '{print $2}')
nw=$(route -n | grep 0.0.0.0 | awk '{print $1}' | grep -v 0.0.0.0 )
#script ui
echo "Internal IP : $ip"
echo "press 1 to scan"
read a
if [[ $a == "1" ]]
then
      echo "Active Hosts"
      echo "------------"
      nmap $nw/24 | grep Nmap | grep -v "Starting\|done" | awk '{print $5}'
  

fi


