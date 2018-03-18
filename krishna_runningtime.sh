#!/bin/bash

for i in *.log
do
sed 's/krishna://g; s/\//-/g' $i > tmp_$i
grep '\[\|Finished' tmp_$i | awk '{print $1 "\s" $2}' > tmp2_$i
done

for i in tmp2_*
do
# Time Arithmetic

TIME1=$(head -n 1 $i)
TIME2=$(tail -n 1 $i)

# Convert the times to seconds from the Epoch
SEC1=`date +%s -d ${TIME1}`
SEC2=`date +%s -d ${TIME2}`

# Use expr to do the math, let's say TIME1 was the start and TIME2 was the finish
DIFFSEC=`expr ${SEC2} - ${SEC1}`

#echo Start ${TIME1}
#echo Finish ${TIME2}
echo $i > name.txt
echo TimeSeconds ${DIFFSEC} > time.txt
paste name.txt time.txt >> total_time.txt

# Calculate total time used
# And use date to convert the seconds back to something more meaningful
#echo Took `date +%H:%M:%S -ud @${DIFFSEC}`
done

rm tmp*
awk '{len+=$3}{print len}' total_time.txt|tail -1 
