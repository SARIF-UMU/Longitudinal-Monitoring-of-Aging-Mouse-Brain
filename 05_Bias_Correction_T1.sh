#! /bin/bash

cd $analysis_dir

ls -d */*/T1 > T1_list.txt

for f in `cat T1_list.txt`; do


echo -e "Bias field correction for $f \n"

N4BiasFieldCorrection -d 3 -i "$analysis_dir"/"$f"/T1.nii.gz -o "$analysis_dir"/"$f"/T1.nii.gz



done

rm T1_list.txt
