#!/bin/bash

if [ ! $# -eq 1 ];then
	echo "Usage: $0 <directory>"
	exit 1
fi

if [ ! -d $1 ];then
	echo "This directory $1 doesn't exist."
	exit 1
fi

empty=$(ls -l $1 | grep "^-" | awk -F" " ' $5 == 0 {count++} END {print count+0}')
small=$(ls -l $1 | grep "^-" | awk -F" " ' $5 >=1 && $5<=100 {count++}END{print count+0}')
medium=$(ls -l $1 | grep "^-" | awk -F" " '$5>=101 && $5<=1000 {count++}END{print count+0}')
large=$(ls -l $1 | grep "^-" | awk -F" " '$5>1000 {count++}END{print count+0}')

cat << EOF > sizes.txt 
EMPTY=$empty
SMALL=$small
MEDIUM=$medium
LARGE=$large
EOF
