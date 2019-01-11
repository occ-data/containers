#!/bin/bash
cd $1
outputF=$3
subList=$2
echo 'SubjID,L_Hippocampal_tail,L_subiculum,L_CA1,L_hippocampal-fissure,L_presubiculum,L_parasubiculum,L_molecular_layer_HP,L_GC-ML-DG,L_CA3,L_CA4,L_fimbria,L_HATA,L_Whole_hippocampus,R_Hippocampal_tail,R_subiculum,R_CA1,R_hippocampal-fissure,R_presubiculum,R_parasubiculum,R_molecular_layer_HP,R_GC-ML-DG,R_CA3,R_CA4,R_fimbria,R_HATA,R_Whole_hippocampus,Lhippo,Rhippo,eTIV,Brain,TotalGM' > $outputF

#for subj_id in $(ls -d 00*); do # approach A: create the list here, e. g. for rootname 'WG_' in this example
for subj_id in $(cat $subList); do # approach B: use an explicit list
printf "%s,"  "${subj_id}" >> $outputF



for x in Hippocampal_tail subiculum CA1 hippocampal-fissure presubiculum parasubiculum molecular_layer_HP GC-ML-DG CA3 CA4 fimbria HATA Whole_hippocampus; do
printf "%g," `grep -w ${x} ${subj_id}/mri/lh.hippoSfVolumes-T1.v10.txt | awk '{print $2}'` >> $outputF
done

for x in Hippocampal_tail subiculum CA1 hippocampal-fissure presubiculum parasubiculum molecular_layer_HP GC-ML-DG CA3 CA4 fimbria HATA Whole_hippocampus; do
printf "%g," `grep -w ${x} ${subj_id}/mri/rh.hippoSfVolumes-T1.v10.txt | awk '{print $2}'` >> $outputF
done


for x in Left-Hippocampus Right-Hippocampus; do
printf "%g," `grep  ${x} ${subj_id}/stats/aseg.stats | awk '{print $4}'` >> $outputF
done

printf "%g," `cat ${subj_id}/stats/aseg.stats | grep IntraCranialVol | awk -F, '{print $4}'` >> $outputF
printf "%g," `cat ${subj_id}/stats/aseg.stats | grep 'Brain Segmentation Volume,' | awk -F, '{print $4}'` >> $outputF
printf "%g" `cat ${subj_id}/stats/aseg.stats | grep  'Total gray matter volume' | awk -F, '{print $4}'` >> $outputF

echo "" >> $outputF

done
#/bin/bash extract_subfields.sh subjectDir_test  list_subjects.txt hippo_subfield_volume
