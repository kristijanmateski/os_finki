#!/bin/bash

if [ ! $# -eq 1 ];then
	echo "Usage: $0 <filename.csv>"
	exit 1
fi

doc=$1

totalStudent=$(wc -l < $doc)

vkupno=$(($totalStudent - 1))

echo "Exam Scores Analysis"
echo "------------------"
echo "Total Number of Students: $vkupno"

math=$(awk -F, 'NR>1 { countMath+=$3; count++} END {printf "%.2f" ,countMath/count }' "$doc")
science=$(awk -F, 'NR>1 { countScience+=$4; count++} END {printf "%.2f" ,countScience/count}' "$doc")
english=$(awk -F, 'NR>1 { countEnglish+=$5; count++} END {printf "%.2f" ,countEnglish/count}' "$doc")
history=$(awk -F, 'NR>1 { countHistory+=$6; count++} END {printf "%.2f" ,countHistory/count}' "$doc")

echo "Subject Averages:"
echo " Math:	$math"
echo " Science: $science"
echo " English: $english"
echo " History: $history"

mathHigh=$(awk -F, 'NR>1 { print $2, $3}' "$doc" | sort -k3 | tail -1)
mathLow=$(awk -F, 'NR>1 { print $2, $3}' "$doc" | sort -k3 | head -1)

scienceHigh=$(awk -F, 'NR>1 {print $2, $4}' "$doc" | sort -k3 | tail -1)
scienceLow=$(awk -F, 'NR>1 {print $2, $4}' "$doc" | sort -k3 | head -1)

englishHigh=$(awk -F, 'NR>1 { print $2, $5}' "$doc" | sort -k3 | tail -1)
englishLow=$(awk -F, 'NR>1 { print $2, $5}' "$doc" | sort -k3 | head -1)

historyHigh=$(awk -F, 'NR>1 { print $2, $6}' "$doc" | sort -k3 | tail -1)
historyLow=$(awk -F, 'NR>1 { print $2, $6}' "$doc" | sort -k3 | head -1)

echo "                  "
echo "Subject Extreme Performers:"
echo "  Math - Highest: $mathHigh, Lowest: $mathLow"
echo "  Science - Highest: $scienceHigh, Lowest: $scienceLow"
echo "  English - Highest: $englishHigh, Lowest: $englishLow"
echo "  History - Highest: $historyHigh, Lowest: $historyLow"
