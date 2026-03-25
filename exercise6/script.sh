#!/bin/bash


if [ $# -ne 2 ];then
	echo "Usage: $0 <STATUS> <MONTH>"
	exit 1
fi

if [[ ! $2 =~ [0-9]{4}-[0-9]{2} ]];then
	echo "Second argument must be date, example: YYYY-MM"
	exit 1
fi

if [[ ! ( $1 == 'INFO' || $1 == 'WARN' || $1 == 'ERROR' || $1 == 'DEBUG' ) ]];then
	echo "Please write correct STATUS (info,error,warn,debug)"
	exit 1
fi

IFS=$"\n"

file=`cat logs.txt`

mostCommonIpAddress=$(echo "$file" | grep "INFO" | awk -F " " '{ print $4 }' | sort | uniq -c | sort -k 1 -rn | head -1 | awk -F" " '{ print $2 }')

info=$(echo "$file" | awk -F" " -v month="$2" -v status="$1" 'NR>1 && $1 ~ month && $3 == status { count++ } END { print count }')
error=$(echo "$file" | awk -F" " -v month="$2" 'NR>1 && $1 ~ month && $3 == "ERROR" { count++ } END { print count }')
warn=$(echo "$file" | awk -F" " -v month="$2" 'NR>1 && $1 ~ month && $3 == "WARN" { count++ } END { print count }')
debug=$(echo "$file" | awk -F" " -v month="$2" 'NR>1 && $1 ~ month && $3 == "DEBUG" { count++ } END { print count }')

echo "Number of logs with status '$1' in month $2: $info"
echo "Most common IP address for logs with status '$1': $mostCommonIpAddress"
echo "Count per status for month $2:"
echo "DEBUG: $debug"
echo "INFO: $info"
echo "WARN: $warn"
echo "ERROR: $error"
