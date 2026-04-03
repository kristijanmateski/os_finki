#!/bin/bash

if [ $# -ne 1 ];then
	echo "Usage: $0 <directory_name>"
	exit 1
fi

if [ ! -d $1 ];then
	echo "This directory doesn't exist."
	exit 1
fi

tot=`cat $1/*.rez | grep "TOT" | awk -F"," '$1=="w" || $1=="d" {print}' | wc -l`
mun=`cat $1/*.rez | grep "MUN" | awk -F"," '$1=="w" || $1=="d" {print}' | wc -l`
che=`cat $1/*.rez | grep "CHE" | awk -F"," '$1=="w" || $1=="d" {print}' | wc -l`
mci=`cat $1/*.rez | grep "MCI" | awk -F"," '$1=="w" || $1=="d" {print}' | wc -l`
liv=`cat $1/*.rez | grep "LIV" | awk -F"," '$1=="w" || $1=="d" {print}' | wc -l`

cat > results.txt <<EOF
$che CHE
$mci MCI
$mun MUN
$tot TOT
EOF
