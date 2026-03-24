#!/bin/bash

if [ $# -ne 2 ];then
	echo "Usage: $0 <argument1> <argument2>"
	exit 1
fi

IFS=$"\n"
month1=`cat text.csv | grep "$1"`
month2=`cat text.csv | grep "$2"`

for i in $month1;
do
	name1=$(echo $i | awk '{print $1}')
	city1=$(echo $i | awk '{print $2}')
	kwh1=$(echo $i | awk '{print $6}')
	for j in $month2;
	do
		name2=$(echo $j | awk '{print $1}')
		city2=$(echo $j | awk '{print $2}')
		kwh2=$(echo $j | awk '{print $6}')
		if [ "$name1" = "$name2" ] && [ "$city1" = "$city2" ] && [ "$kwh1" -gt "$kwh2" ];then
			echo $name1 $name2
		fi
	done
done
