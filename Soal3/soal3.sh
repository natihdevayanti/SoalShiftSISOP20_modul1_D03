
#no3a

#!/bin/bash
for i in {1..28}
do
wget -O pdkt_kusuma_$i https://loremflickr.com/320/240/cat -a wget.log
done

#no3b
crontab -e

5 6-23/8 * * 0-5 /home/elvira/soal3.sh


#perantara

mkdir kenangan
mkdir duplicate

#no3c

#!/bin/bash

grep "Location" wget.log > location.log
readarray line < location.log
for ((i=0; i<28; i++))
do
for ((j=0; j<=i; j++))
do
if [ $i == $j ]
then
continue
elif [ "${line[$i]}" == "${line[$j]}" ]
then
mv pdkt_kusuma_"$(($i+1))".jpg ./duplicate/duplicate_"$i".jpg
fi
done
done

for ((i=1; i<=28; i++))
do
mv pdkt_kusuma_"$i".jpg ./kenangan/kenangan_"$i".jpg
done
cp wget.log wget.log.bak
