#!/bin/bash

if [ $# -lt 1 ];then
	echo "Must have at least one argument"
	exit 1
fi

> report.txt

for f in $@;do

	if [ ! -e "$f" ];then
		continue
	fi

	if [[ ! -f "$f"  ||  "$f" != *.py ]];then
		continue
	fi

	python $f
	EXIT_STATUS=$?
	status=""

	if [ $EXIT_STATUS -eq 0 ];then
		status="SUCCESS"
	else
		status="FAIL"
	fi
	echo "File $f | Status: $status | Exit code: $EXIT_STATUS" >> report.txt
done
