#! /bin/bash


for s in `cat $analysis_dir/sub_scan_list.txt` ; do

t2_1=$analysis_dir/$s/rsfMRI_1/rsfMRI_1_Brain.nii
t2_1_gz=$analysis_dir/$s/rsfMRI_1/rsfMRI_1.nii.gz
t2_1_par=$analysis_dir/$s/rsfMRI_1/rsfMRI_1_mcf.par

t2_2=$analysis_dir/$s/rsfMRI_2/rsfMRI_2_Brain.nii
t2_2_gz=$analysis_dir/$s/rsfMRI_2/rsfMRI_2.nii.gz
t2_2_par=$analysis_dir/$s/rsfMRI_2/rsfMRI_2_mcf.par




cd $script_dir

if test -f "$t2_1_gz"; then

#gzip -d "$t2_1_gz"

echo -e "Creating MoCo QC report for $t2_1_gz\n"

/usr/local/MATLAB/R2020a/bin/matlab -nodisplay -r 'nii_qa_moco('\'$t2_1_gz\'','\'$t2_1_par\''); exit;'

mv MoCo_Report.png "$analysis_dir"/"$s"/rsfMRI_1/MoCo_Report.png
mv qa_moco.tab "$analysis_dir"/"$s"/rsfMRI_1/qa_moco.tab

#gzip "$t2_1"
#rm "$t2_1"
fi



cd $script_dir

if test -f "$t2_2_gz"; then

#gzip -d "$t2_2_gz"

echo -e "Creating MoCo QC report for $t2_2_gz\n"

/usr/local/MATLAB/R2020a/bin/matlab -nodisplay -r 'nii_qa_moco('\'$t2_2_gz\'','\'$t2_2_par\''); exit;'

mv MoCo_Report.png "$analysis_dir"/"$s"/rsfMRI_2/MoCo_Report.png
mv qa_moco.tab "$analysis_dir"/"$s"/rsfMRI_2/qa_moco.tab

#gzip "$t2_2"
#rm "$t2_2"

fi







done