#!/bin/bash

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"


trap ctrl_c INT

function ctrl_c(){
	clear
	echo -e "${grayColour}[!] Exiting...${endColour}"
	sleep 0.5
	exit 1
}

function fast_nmap(){
	clear
	nmap -p- --min-rate 10000 --open -vvv $ip -oN scan
	(grep "PORT" scan && grep "open" scan | sed '1d') > OpenPorts.txt
	clear
	echo -e "${greenColour}[+] Scan completed${endColour}"
}

function normal_nmap(){
	clear
	nmap -p- --min-rate 5000 --open -vvv -n $ip -oN scan
	(grep "PORT" scan && grep "open" scan | sed '1d') > OpenPorts.txt
	clear
	echo -e "${greenColour}[+] Scan completed${endColour}"
}

function complete_nmap(){
	clear
	nmap -p- -sVC -sC --min-rate 5000 --open -sS -vvv -n -Pn $ip -oN scan
	(grep "PORT" scan && grep "open" scan | sed '1d') > OpenPorts.txt
	clear
	echo -e "${greenColour}[+] Scan completed${endColour}"
}

function start(){
	clear
	echo -e "${greenColour}"
	echo " _____     _       _____               "
	echo "|  _  |_ _| |_ ___|   | |_____ ___ ___"
	echo "|     | | |  _| . | | | |     | .'| . |"
	echo "|__|__|___|_| |___|_|___|_|_|_|__,|  _|"
	echo "                                  |_|  "
	echo -e "${endColour}"
	echo -e "${grayColour}by 666aalexx${endColour}\n"
	read -p "Ip: " ip
	echo -e "\n\n${grayColour}Choose scan mode: ${endColour}"
	echo -e "\n${grayColour}[1]${endColour} Fast"
	echo -e "${grayColour}[2]${endColour} Normal"
	echo -e "${grayColour}[3]${endColour} Complete\n"
	read -p "> " opt

if [ $opt == "1" ]; then
         clear
         fast_nmap
elif [ $opt == "2" ]; then
         clear
         normal_nmap
elif [ $opt == "3" ]; then
         clear
         complete_nmap
else
         echo -e "${redColour}Error${endColour}"
         sleep 1
         clear
         echo -e "${grayColour}Retrying...${endColour}"
         sleep 1
         start
fi
}

start
