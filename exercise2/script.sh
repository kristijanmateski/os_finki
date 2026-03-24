#!/bin/bash

if [ ! $# -eq 1 ];then
	echo "Error, $0 <directory name>"
	exit 1
fi

mkdir -p ./copiedFiles

copiedFiles=0
totalSize=0
totalNumberOfLines=0
largestFile=0
longestName=""
for i in $1/*[0-9].csv;
do
	name=$(basename "$i")
	perm=$(ls -l $i | cut -c8)
	if [ "perm" = "r" ];then
		continue
	fi

	copiedFiles=$(($copiedFiles + 1))
	cp "$i" $1/copiedFiles

	size=$(ls -l $i | awk '{print $5}')
	totalSize=$(($totalSize + $size))

	length=$(cat $i | wc -l)
	totalNumberOfLines=$(($totalNumberOfLines + $length))

	if [ "$size" -gt "$largestFile" ];then
		largestFile=$size
	fi

	nameLength=${#name}
	if [ "$nameLength" -gt "${#longestName}" ];then
		longestName="$name"
	fi
done

cat << EOF > statistics.txt
copiedFiles: $copiedFiles
totalSize: $totalSize
totalNumberOfLines: $totalNumberOfLines
largestFile: $largestFile
longestName: $longestName
EOF
