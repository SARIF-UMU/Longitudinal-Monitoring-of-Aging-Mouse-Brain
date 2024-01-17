#! /bin/bash


for s in `cat $analysis_dir/sub_scan_list.txt`; do

Subject=${s:0:7}

cd $analysis_dir/$Subject

echo $PWD


# Define Template image and masks here
Template=/mnt/Data/Projects/Aging_FC/Scripts/Atlas/GrandJean/Template.nii.gz
Atlas=/mnt/Data/Projects/Aging_FC/Scripts/Atlas/GrandJean/Atlas.nii.gz
WM_Mask=/mnt/Data/Projects/Aging_FC/Scripts/Atlas/GrandJean/WM_Mask.nii.gz
VEN_Mask=/mnt/Data/Projects/Aging_FC/Scripts/Atlas/GrandJean/VEN_Mask.nii.gz
rsfmri_1_Mask=rsfMRI_1_Mask.nii.gz
rsfmri_2_Mask=rsfMRI_2_Mask.nii.gz


mv STC_MC_Sess_1.nii.gz $Sess_1_Brain
mv STC_MC_Sess_2.nii.gz $Sess_2_Brain

# Get median Func for registration to GJ Atlas


fslmaths $Sess_1_Brain -Tmedian rsfmri_1_Median.nii.gz
fslmaths $Sess_2_Brain -Tmedian rsfmri_2_Median.nii.gz


# Register Median to GJ Atlas for transformation matrix

flirt -in rsfmri_1_Median.nii.gz -ref "$Template" -out rsfmri_1_Median_Reg.nii.gz -omat Rsfmri_1_Matrix.mat -bins 256 -cost corratio -searchrx -90 90 -searchry -90 90 -searchrz -90 90 -dof 12  -interp nearestneighbour
flirt -in rsfmri_2_Median.nii.gz -ref "$Template" -out rsfmri_2_Median_Reg.nii.gz -omat Rsfmri_2_Matrix.mat -bins 256 -cost corratio -searchrx -90 90 -searchry -90 90 -searchrz -90 90 -dof 12  -interp nearestneighbour

# Apply brain mask & transformation matrix to Func


flirt -in $Sess_1_Brain -applyxfm -init Rsfmri_1_Matrix.mat -out rsfMRI_1_Brain_Reg.nii.gz -paddingsize 0.0 -interp nearestneighbour -ref "$Template"
flirt -in $Sess_2_Brain -applyxfm -init Rsfmri_2_Matrix.mat -out rsfMRI_2_Brain_Reg.nii.gz -paddingsize 0.0 -interp nearestneighbour -ref "$Template"

# # Inverse transformation matrix

# convert_xfm -omat Inv_Rsfmri_1_Matrix.mat -inverse Rsfmri_1_Matrix.mat
# convert_xfm -omat Inv_Rsfmri_2_Matrix.mat -inverse Rsfmri_2_Matrix.mat

# # Create Subject-specific GJ Atlas and  WM & VEN masks

# flirt -in "$Atlas" -applyxfm -init Inv_Rsfmri_1_Matrix.mat -out rsfMRI_1_Atlas.nii.gz -paddingsize 0.0 -interp nearestneighbour -ref rsfmri_1_Median.nii.gz
# flirt -in "$Atlas" -applyxfm -init Inv_Rsfmri_1_Matrix.mat -out rsfMRI_2_Atlas.nii.gz -paddingsize 0.0 -interp nearestneighbour -ref rsfmri_2_Median.nii.gz
# flirt -in "$WM_Mask" -applyxfm -init Inv_Rsfmri_1_Matrix.mat -out rsfMRI_1_WM_Mask.nii.gz -paddingsize 0.0 -interp nearestneighbour -ref rsfmri_1_Median.nii.gz
# flirt -in "$WM_Mask" -applyxfm -init Inv_Rsfmri_2_Matrix.mat -out rsfMRI_2_WM_Mask.nii.gz -paddingsize 0.0 -interp nearestneighbour -ref rsfmri_2_Median.nii.gz
# flirt -in "$VEN_Mask" -applyxfm -init Inv_Rsfmri_1_Matrix.mat -out rsfMRI_1_VEN_Mask.nii.gz -paddingsize 0.0 -interp nearestneighbour -ref rsfmri_1_Median.nii.gz
# flirt -in "$VEN_Mask" -applyxfm -init Inv_Rsfmri_2_Matrix.mat -out rsfMRI_2_VEN_Mask.nii.gz -paddingsize 0.0 -interp nearestneighbour -ref rsfmri_2_Median.nii.gz


echo "Registration done for Subject $Subject."


done

