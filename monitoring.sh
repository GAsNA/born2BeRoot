#!/bin/bash
wall $'\t#Architecture: '`uname -a` \
\
$'\n\t#CPU physical : '`nproc --all` \
\
$'\n\t#vCPU : '`cat /proc/cpuinfo | grep processor | wc -l` \
\
$'\n\t'`free -m | awk 'NR == 2 {printf "#Memory Usage: %s/%sMB (%0.2f%%)", $3, $2, $3*100/$2}'` \
\
$'\n\t'`df -h | awk '$NF == "/"{printf "#Disk Usage: %d/%dGB (%s)", $3, $2, $5}'`\
\
$'\n\t'`mpstat | grep all | awk '{printf "#CPU Load: %0.2f%%", 100-$13}'`\
\
$'\n\t#Last boot: '`who -b | cut -c 23-38` \
\
$'\n\t#LVM use: '`lsblk | grep lvm | awk '{if ($1) {print "yes";exit;} else {print "no"} }'` \
\
$'\n\t#Connexions TCP : '`netsat -anp | grep :4242 | grep ESTABLISHED | wc -l`" ESTABLISHED" \
\
$'\n\t#User log: '`users | wc -l` \
\
$'\n\t#Network: IP '`hostname -I`"("`ip a | grep link/ether | awk '{print $2}'`")" \
\
$'\n\t'`cat /var/log/sudo/sudo.log | grep TSID | wc -l | awk '{printf "#Sudo : %d cmd", $1}'`
