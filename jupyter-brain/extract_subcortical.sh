#!/bin/bash
cd $1
outputF=$3
subList=$2
#bash
echo "SubjID,LLatVent,RLatVent,Lthal,Rthal,Lcaud,Rcaud,Lput,Rput,Lpal,Rpal,Lhippo,Rhippo,Lamyg,Ramyg,Laccumb,Raccumb,ICV" > $outputF
for sub_id in $(cat $subList); do
#for sub_id in `ls -d subj*`; do 
printf "%s,"  "${sub_id}" >> $outputF
for x in Left-Lateral-Ventricle Right-Lateral-Ventricle Left-Thalamus-Proper Right-Thalamus-Proper Left-Caudate Right-Caudate Left-Putamen Right-Putamen Left-Pallidum Right-Pallidum Left-Hippocampus Right-Hippocampus Left-Amygdala Right-Amygdala Left-Accumbens-area Right-Accumbens-area; do
printf "%g," `grep  ${x} ${sub_id}/stats/aseg.stats | awk '{print $4}'` >> $outputF
done
printf "%g" `cat ${sub_id}/stats/aseg.stats | grep IntraCranialVol | awk -F, '{print $4}'` >> $outputF
echo "" >> $outputF
done

