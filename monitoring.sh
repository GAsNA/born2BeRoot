#!/bin/bash

echo -ne "\t#Architecture: "

echo -ne "\n\t#CPU physical : "
nproc --all

echo -ne "\t#vCPU : "

echo -ne "\n\t#Memory Usage: "

echo -ne "\n\t#Disk Usage: "

echo -ne "\n\t#CPU load: "

echo -ne "\n\t#Last boot: "
who -b | cut -c 23-38

echo -ne "\t#LVM use: "

echo -ne "\n\t#Connexions TCP : "
netstat -anp | grep :4242 | grep ESTABLISHED | wc -l | tr '\n' ' '
echo "ESTABLISHED"

echo -ne "\t#User log: "
users | wc -l

echo -ne "\t#Network: IP "
ip -c a | grep "inet " | grep 10 | cut -c 15-23 | tr '\n' ' '
echo -n "("
ip -c a | grep ether | cut -c 21-37 | tr '\n' ')'
echo ""

echo -ne "\t#Sudo : "
cat /var/log/sudo/sudo.log | grep TSID | wc -l | tr '\n' ' '
echo "cmd"

