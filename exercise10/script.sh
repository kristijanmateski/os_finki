#!/bin/bash

if [ $# -ne 1 ];then
	echo "Usage: $0 <file_name>"
	exit 1
fi

if [ ! -f "$1" ];then
	echo "This file doesn't exist"
	exit 1
fi

file=`cat $1`
touch report.txt
IFS=$'\n'
echo "product total category" > report.txt

for f in $file;
do
	row=$(echo $f | awk -F";" '{print $2 * $3}')
	name=$(echo $f | awk -F";" '{print $1}')
	if [ "$row" -lt 500 ];then
		category="LOW"
	elif [ "$row" -ge 500 ] && [ "$row" -le 1000 ];then
		category="MEDIUM"
	else
		category="HIGH"
	fi
	echo $name $row $category>> report.txt
done
