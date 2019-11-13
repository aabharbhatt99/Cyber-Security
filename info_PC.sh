#!/bin/bash
#To grab the info.
interface=$(ifconfig | grep RUNNING | grep -v lo | awk '{print $1}' | cut -d: -f1)
ip=$(ifconfig | grep inet | grep -v "inet6\|127.0.0.1" | awk '{print $2}')
gw=$(route -n | grep "UG" | awk '{print $2}')
mac=$(ifconfig | grep ether | awk '{print $2}')
#script UI
echo "MENU"
echo "-----"
echo "1. Active Interface"
echo "2. Internal IP" 
echo "3. Gateway"
echo "4. MAC"
echo ""
echo "enter option :"
read a
#condition
if [[ $a == "1" ]]
then
	echo "Active Interface : $interface "
elif [[ $a == "2" ]]
then
	echo "Internal IP : $ip"
elif [[ $a == "3" ]]
then
	echo "Gateway : $gw"
elif [[ $a == "4" ]]
then
	echo "MAC : $mac"
else 
	echo "please try again"
	echo ""
fi


