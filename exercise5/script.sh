#!/bin/bash

if [ ! "$#" -eq 2 ];then
	echo "Usage: $0 <argument1> <argument2>"
	exit 1
fi

if [ ! -f "$1" ];then
	echo "File $1 doesn't exist."
	exit 1
fi

doc=`cat $1`

touch "$2"

IFS=$'}'

avg=$(echo $doc | grep "duration" | awk -F" " '{ total+=$2; count++} END {print total/count}')

echo "id, filepath, filesize, is_longer" > $2

count=1

for i in $doc;
do
	filepath=$(echo $i | grep "filepath" | awk -F" " '{print $2}' | tr -d '"' | tr -d ',')
	filesize=$(echo $i | grep "filesize" | awk -F" " '{print $2}' | tr -d '"')
	duration=$(echo $i | grep "duration" | awk -F" " '{print $2}' | tr -d ',')
	is_longer=$(awk -v dur="$duration" -v av="$avg" 'BEGIN {print (dur > av) ? 1 : 0}')

	if [ ! -z "$filepath" ] && [ ! -z "$filesize" ] && [ ! -z "$duration" ];then
		echo "$count,$filepath,$filesize,$is_longer" >> $2
		count=$(($count + 1))
	fi
done
