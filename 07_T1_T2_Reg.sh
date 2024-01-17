#! /bin/bash

cd $analysis_dir

ls -d */*  > sub_scan_list.txt

for s in `cat $analysis_dir/sub_scan_list.txt` ; do

T1_Image="$s"/T1/T1.nii.gz
T1_Mask="$s"/T1/T1_Mask.nii.gz
Rsfmri_1="$s"/rsfMRI_1/rsfMRI_1.nii.gz
Rsfmri_2="$s"/rsfMRI_2/rsfMRI_2.nii.gz
Rsfmri_1_Median="$s"/rsfMRI_1/rsfMRI_1_Median.nii.gz
Rsfmri_1_Mask="$s"/rsfMRI_1/rsfMRI_1_Mask.nii.gz
Rsfmri_2_Median="$s"/rsfMRI_2/rsfMRI_2_Median.nii.gz
Rsfmri_2_Mask="$s"/rsfMRI_2/rsfMRI_2_Mask.nii.gz



# rsfMRI 1

if [ -f $Rsfmri_1 ]; then

fslmaths "$Rsfmri_1" -Tmedian "$Rsfmri_1_Median"

# registration -> correlation ratio - dof9
flirt -in "$Rsfmri_1_Median" -ref "$T1_Image" -out "$analysis_dir"/"$s"/rsfMRI_1/T1rsfMRI_1_dof9.nii -omat "$analysis_dir"/"$s"/rsfMRI_1/T1rsfMRI_1_dof9.mat -bins 256 -cost corratio -searchrx -180 180 -searchry -180 180 -searchrz -180 180 -dof 9 -interp trilinear

# Invert transformation matrix
convert_xfm -omat "$analysis_dir"/"$s"/rsfMRI_1/T1rsfMRI_1_dof9_INV.mat -inverse "$analysis_dir"/"$s"/rsfMRI_1/T1rsfMRI_1_dof9.mat
rm "$analysis_dir"/"$s"/rsfMRI_1/T1rsfMRI_1_dof9.mat
mv "$analysis_dir"/"$s"/rsfMRI_1/T1rsfMRI_1_dof9_INV.mat "$analysis_dir"/"$s"/rsfMRI_1/T1rsfMRI_1_dof9.mat


# apply registration -> correlation ratio - dof9
flirt -in "$T1_Mask" -applyxfm -init "$analysis_dir"/"$s"/rsfMRI_1/T1rsfMRI_1_dof9.mat -out "$Rsfmri_1_Mask" -paddingsize 0.0 -interp trilinear -ref "$Rsfmri_1_Median"

# mask -> correlation ratio - dof9
#fslmaths "$Rsfmri_1" -mas "$Rsfmri_1_Mask" "$analysis_dir"/"$s"/rsfMRI_1/rsfMRI_1_Brain.nii.gz

rm "$Rsfmri_1_Median"

echo -e "$Rsfmri_1 Registered!\n"

fi



# rsfMRI 2

if [ -f $Rsfmri_2 ]; then

fslmaths "$Rsfmri_2" -Tmedian "$Rsfmri_2_Median"

# registration -> correlation ratio - dof9
flirt -in "$Rsfmri_2_Median" -ref "$T1_Image" -out "$analysis_dir"/"$s"/rsfMRI_2/T1rsfMRI_2_dof9.nii -omat "$analysis_dir"/"$s"/rsfMRI_2/T1rsfMRI_2_dof9.mat -bins 256 -cost corratio -searchrx -180 180 -searchry -180 180 -searchrz -180 180 -dof 9 -interp trilinear

# Invert transformation matrix
convert_xfm -omat "$analysis_dir"/"$s"/rsfMRI_2/T1rsfMRI_2_dof9_INV.mat -inverse "$analysis_dir"/"$s"/rsfMRI_2/T1rsfMRI_2_dof9.mat
rm "$analysis_dir"/"$s"/rsfMRI_2/T1rsfMRI_2_dof9.mat
mv "$analysis_dir"/"$s"/rsfMRI_2/T1rsfMRI_2_dof9_INV.mat "$analysis_dir"/"$s"/rsfMRI_2/T1rsfMRI_2_dof9.mat

# apply registration -> correlation ratio - dof9
flirt -in "$T1_Mask" -applyxfm -init "$analysis_dir"/"$s"/rsfMRI_2/T1rsfMRI_2_dof9.mat -out "$Rsfmri_2_Mask" -paddingsize 0.0 -interp trilinear -ref "$Rsfmri_2_Median"

# mask -> correlation ratio - dof9
#fslmaths "$Rsfmri_2" -mas "$Rsfmri_2_Mask" "$analysis_dir"/"$s"/rsfMRI_2/rsfMRI_2_Brain.nii.gz

rm "$Rsfmri_2_Median"

echo -e "$Rsfmri_2 Registered!\n"

fi




done