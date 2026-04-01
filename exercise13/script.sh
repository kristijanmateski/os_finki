#!/bin/bash

if [ $# -ne 3 ];then
        echo "Usage: $0 <x> <y> <directory_name>"
        exit 1
fi

if [ -d "$3" ];then
        rm -r $3
fi

mkdir -p ./$3

fD=$1
sD=$2
dest=$3

getFiles(){
for i in *.txt;do
        datumi=$(ls -l $i | awk -F" " '{print $7}')

        if [ $datumi -ge $fD ] && [ $datumi -le $sD ];then
                echo $i
        fi
done
}
count=0
findAllTxtFiles(){
        for i in $(getFiles);do
                size=$(ls -l $i | awk -F" " '{print $5}')
                total=$(grep -o "echo" $i | wc -l)
                if [ $size -gt 150 ];then
                        new_name="$dest/index_${total}.txt"

                        if [ -f "$new_name" ];then
                                count=$((count + 1))
                                new_name="$dest/index_${total}${count}.txt"
                        fi
                        cp "$i" "$new_name"
                fi
done

}

findAllTxtFiles
