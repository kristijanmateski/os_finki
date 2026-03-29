#!/bin/bash

if [ $# -ne 1 ];then
	echo "Usage: $0 <directory_name>"
	exit 1
fi

if [ ! -d $1 ];then
	echo "This directory $1 does not exist."
	exit 1
fi

mkdir -p ./copiedFiles

for f in $1/[a-zA-Z]*.txt;do
	per=$(ls -l $f | cut -c8)
	if [ ! $per == "r" ];then
		continue
	fi

	cp "$f" ./copiedFiles
done

total=$(ls ./copiedFiles | wc -l)

totalSize=$(ls -l ./copiedFiles | awk -F" " 'NR>1 {total+=$5}END{print total}')

totalLines=$(cat ./copiedFiles/*  | wc -l)

largestFile=$(ls -l ./copiedFiles | awk -F" " 'NR>1 {print $5}' | sort -n | head -1)

longestName=$(ls ./copiedFiles | awk -F" " '{print  $1,length($1)}' | sort -n | head -1 | awk -F" " '{print $1}')

cat > statistics.txt << EOF
copiedFiles: $total
totalSize: $totalSize
totalNumberOfLines: $totalLines
largestFile: $largestFile
longestName: $longestName
EOF
