#!/bin/bash

if [ $# -ne 1 ];then
        echo "Usage: $0 <directory_name>"
        exit 1
fi

if [ ! -d $1 ];then
        echo "$1 is not a directory."
        exit 1
fi

mkdir -p ./processed

for f in $1/*[0-9].txt;do
        per=$(ls -l $f | cut -c8)

        if [ ! $per = "r" ];then
                continue
        fi

        name=$(basename $f | awk -F"." '{print $1}')

        cat $f | tr '[:upper:]' '[:lower:]' | tr ";,.-" " " | tr -s " " "\n" | sort | uniq | grep -E '^[a-z]+$' >./processed/$name.out
done

files=$(ls ./processed | wc -l)

total=$(cat ./processed/* | wc -l)

fileName=$(wc -w ./processed/* | grep -v "total" | sort -k1 -r | head -1 | awk -F" " '{print $2}' | awk -F'/' '{ print $3}' | sed 's/\.out/\.txt/')

max=$(wc -w ./processed/* | grep -v "total" | sort -k1 -r | head -1 | awk -F" " '{print $1}')

cat > summary.txt << EOF
processedFiles: $files
totalUniqueWords: $total
fileWithMostUniqueWords: $fileName
maxUniqueWords: $max
EOF
