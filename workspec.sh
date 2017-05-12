#!/bin/bash

dir=/net/IT/WorkStats
nm=`hostname`
wait=$((1 + RANDOM % 300))
IFS=$'\n'

echo $wait

sleep $wait
#sudo su &
wkfl=$dir/$nm.tmp
touch $wkfl
cpu=`cat /proc/cpuinfo | grep "model name"`
cor=0

for line in $cpu; do

        echo $line >> $wkfl
	cor=$(($cor+1))

done

echo "there are $cor cores" >> $wkfl
echo "====== CPU =====" >> $wkfl




dm=`dmidecode -t memory | grep Size` 
slt=0
for line in $dm; do

	echo $line >> $wkfl
	slt=$(($slt+1))
done

echo "there are $slt memory slots" >> $wkfl
echo "====== MEM =====" >> $wkfl

echo "Host: $nm" >>  $wkfl

