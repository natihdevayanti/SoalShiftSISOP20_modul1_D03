#!/bin/bash 

echo "Soal 1: "
a=$(awk -F"\t" 'NR > 1 {Data[$13] += $21} END { for (i in Data) print Data[i],i }' /Users/putrinatih/Downloads/Sample-Superstore.tsv | sort -g | head -1)
echo "$a"

echo "Soal 2: "
b=$(awk -F"\t" 'NR > 1 {if ($13 == "Central") {Reg[$11] += $21}} END { for (i in Reg) print Reg[i],i }' /Users/putrinatih/Downloads/Sample-Superstore.tsv | sort -g | head -2)
echo "$b"

echo "Soal 3: "
c=$(awk -F"\t" 'NR > 1 {if ($13 == "Central") {if ($11 == "Texas" || $11 == "Illinois") {Data[$17] += $21} } } END { for (i in Data) print Data[i],i }' /Users/putrinatih/Downloads/Sample-Superstore.tsv | sort -g | head -10)
echo "$c"
