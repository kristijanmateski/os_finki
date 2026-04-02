#!/bin/bash

if [ $# -ne 2 ];then
	echo "Must have just two arguments !!!"
	exit 1
fi

if [ ! -d $1 ];then
	echo "This directory doesn't exist!"
	exit 1
fi


mkdir -p $2
files=$(ls $1 | grep "^[a-z]*\.txt$")
for f in $files;do
	name=$(echo $f | sed 's/\.txt/\.moved_txt/')
	mv $f ./$2/$name
	echo "SUCCESSFULL"
done
