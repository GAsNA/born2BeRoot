#!/bin/bash

echo -ne "\t#Architecture: "
uname -a

echo -ne "\t#CPU physical : "
nproc

echo -ne "\t#vCPU : "
cat /proc/cpuinfo | grep processor | wc -l

echo -ne "\t#Memory Usage: "
free -m | sed -n 2p | cut -c 31-32 | tr '\n' '/'
free -m | sed -n 2p | cut -c 18-21 | tr '\n' "M"
echo -n "B ("
free -m | awk 'NR == 2 {printf $3/$2*100}' | numfmt --format=%0.2f
echo "%)"

echo -ne "\t#Disk Usage: "
df -h --total | sed -n 12p | awk '{printf $3}' | tr 'G' '/'
df -h --total | sed -n 12p | awk '{printf $2}'
echo -n "b ("
df -h --total | sed -n 12p | awk '{print $5}' | tr '\n' ')'
echo ""

echo -ne "\t#CPU load: "
mpstat | grep all | awk '{printf "%0.2f%%\n", 100-$13}'

echo -ne "\t#Last boot: "
who -b | awk '{print $3}' | tr '\n' ' '
who -b | awk '{print $4}'

echo -ne "\t#LVM use: "
if [ $(lsblk | grep LVM | wc -l) -gt 0 ]
then
	echo "yes"
else
	echo "no"
fi

echo -ne "\t#Connexions TCP : "
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
