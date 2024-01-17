#! /bin/bash
rm -r $script_dir/logs/08_mcflirt.txt

cd $analysis_dir

for s in `cat $analysis_dir/sub_scan_list.txt` ; do

Subject=${s:5:5}


python_brain_1=$analysis_dir/$s/rsfMRI_1/rsfMRI_1.nii.gz
python_brain_2=$analysis_dir/$s/rsfMRI_2/rsfMRI_2.nii.gz


if [ -f $python_brain_1 ]; then

echo -e "Preparing motion parameters for $Subject - Session 1..."

echo -e "mcflirt -in "$python_brain_1" -plots" >> $script_dir/logs/08_mcflirt.txt

echo -e "Done!"

fi


if [ -f $python_brain_2 ]; then

echo -e "Preparing motion parameters for $Subject - Session 2..."

echo -e "mcflirt -in "$python_brain_2" -plots" >> $script_dir/logs/08_mcflirt.txt

echo -e "Done!"

fi


done
