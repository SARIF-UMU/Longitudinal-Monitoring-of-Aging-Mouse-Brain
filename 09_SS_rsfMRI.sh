#! /bin/bash

ls -d */*  > sub_scan_list.txt

for s in `cat $analysis_dir/sub_scan_list.txt` ; do


rsfMRI_1_data="$analysis_dir"/"$s"/rsfMRI_1/rsfMRI_1.nii.gz
rsfMRI_2_data="$analysis_dir"/"$s"/rsfMRI_2/rsfMRI_2.nii.gz
rsfMRI_1_mask="$analysis_dir"/"$s"/rsfMRI_1/rsfMRI_1_Mask.nii.gz
rsfMRI_2_mask="$analysis_dir"/"$s"/rsfMRI_2/rsfMRI_2_Mask.nii.gz


subj=${s:5:5}
months=${s:17:2}

if [ -f $rsfMRI_1_data ]; then
fsleyes render  --scene ortho -hc --size 1600 600 --outfile "$analysis_dir"/"$s"/rsfMRI_1/"$subj"_"$months"_rsfMRI_1_brain_masked.png  "$rsfMRI_1_data" "$rsfMRI_1_mask" -ot mask -o -w 5
echo -e "Getting screenshot of $rsfMRI_1_data \n"
fi

if [ -f $rsfMRI_2_data ]; then
fsleyes render  --scene ortho -hc --size 1600 600 --outfile "$analysis_dir"/"$s"/rsfMRI_2/"$subj"_"$months"_rsfMRI_2_brain_masked.png  "$rsfMRI_2_data" "$rsfMRI_2_mask" -ot mask -o -w 5
echo -e "Getting screenshot of $rsfMRI_2_data \n"
fi


done
