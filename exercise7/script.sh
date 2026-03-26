#!/bin/bash


if [ $# -ne 1 ];then
        echo "USAGE: $0 <DIRECTORY_NAME>"
        exit 1
fi


if [ ! -d "$1" ];then
	echo "$1 is not a directory"
	exit
fi

mkdir -p ./copiedFiles

files="$1"

count=0

for f in "$files"/*[0-9]*.csv;
do
	name=$(basename $f)
	stats=$(ls -l $f | cut -c8)

	if [ "$stats" != "r" ];then
		continue
	fi
	count=$(($count + 1))
	cp $f "./copiedFiles"
done

size=$(ls -l  ./copiedFiles | awk -F" " '{ sum+=$5 } END { print sum }' )

line=$(cat ./copiedFiles/* | wc -l)

largestFile=$(ls -l ./copiedFiles | awk -F" " '{print $5}' | sort -n | tail -1)

largestName=$(ls -l ./copiedFiles | awk -F" " -v file="$largestFile" '$5 == file { print $9 } ')

longestName=$(ls ./copiedFiles | awk '{ print $1, length($1)}' | sort -k2 | head -1 | awk -F" " '{print $1}'
)

cat > statistics.txt << EOF
copiedFiles: $count
totalSize: $size
totalNumberOfLines: $line
largestFile: $largestFile
longestName: $longestName
EOF
