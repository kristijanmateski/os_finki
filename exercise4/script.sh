#!/bin/bash

if [ $# -ne 1 ];then
	echo "Usage: $0 <folder_name>"
	exit 1
fi

doc="$1"

mkdir -p ./compressed

count=0

for f in "$doc"/*[0-9].txt;
do
	name=$(basename $f)
	perm=$(ls -l $f | cut -c8)

	if [ "$perm" != "r" ];
	then
		continue
	fi
	count=$(($count + 1))
	gzip -c "$f"  > "./compressed/${name}.gz"

	bytes=$(ls -l "$f" | awk -F" " '{print $5}')
	totalBytes=$(($totalBytes + $bytes))
done

bestSize=999999
bestCompressionName=""
longestName=""

for j in ./compressed/*.gz;
do
	name=$(basename "$j")
	bytes=$(ls -l "$j" | awk -F" " '{print $5}')
	totalBytesCompressed=$(($totalBytesCompressed + $bytes))

	if [ "$bytes" -lt "$bestSize" ];then
		bestSize=$bytes
		bestCompressionName="$name"
	fi

	if [ "${#name}" -gt "${#longestName}" ];then
		longestName="$name"
	fi

done

cat > statistics.txt << EOF
FilesCompressed: $count
totalOriginalSize: $totalBytes
totalCompressedSize: $totalBytesCompressed
bestCompressionName: $bestCompressionName
longestName: $longestName
EOF
