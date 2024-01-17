#! /bin/bash

cd $analysis_dir

ls -d */*/T1 > T1_list.txt

for s in `cat T1_list.txt` ; do

T1="$analysis_dir"/$s/T1.nii.gz
Template="$script_dir"/Template.nii.gz
Template_Mask="$script_dir"/Template_Mask.nii.gz


echo -e "SkullStripping...\n"

cd $script_dir

python ./skullstripper_v2.py -in "$T1" -ref "$Template" -refmask "$Template_Mask" -out T1_Mask &> /dev/null

mv masks/T1_Mask.nii "$analysis_dir"/"$s"/

gzip "$analysis_dir"/"$s"/T1_Mask.nii

# Swap L-R if needed
fslswapdim "$analysis_dir"/"$s"/T1_Mask.nii.gz -x y z "$analysis_dir"/"$s"/T1_Mask.nii.gz
fslswapdim "$analysis_dir"/"$s"/T1.nii.gz -x y z "$analysis_dir"/"$s"/T1.nii.gz

fslmaths "$analysis_dir"/"$s"/T1.nii.gz -mas "$analysis_dir"/"$s"/T1_Mask.nii.gz "$analysis_dir"/"$s"/T1_SkullStripped.nii.gz

done

rm "$analysis_dir"/T1_list.txt