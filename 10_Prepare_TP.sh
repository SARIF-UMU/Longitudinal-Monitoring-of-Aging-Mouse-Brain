#! /bin/bash

Month=$1


###############################################################
#Move desired TP under subject main folder for further analysis
###############################################################


echo $Month

cd $analysis_dir
ls -d */* > sub_scan_list.txt

for t in `cat $analysis_dir/sub_scan_list.txt`;

do

Subject=${t:0:7}
TP=${t:8:2}

echo $Subject
echo $TP

if [[ $TP == $Month ]]; then


	cp $analysis_dir/$Subject/$TP/rsfMRI_1/rsfMRI_1.nii.gz $analysis_dir/$Subject
	cp $analysis_dir/$Subject/$TP/rsfMRI_1/rsfMRI_1_Mask.nii.gz $analysis_dir/$Subject

	if [ -d "$analysis_dir/$Subject/$TP/rsfMRI_2" ]; then

		cp $analysis_dir/$Subject/$TP/rsfMRI_2/rsfMRI_2.nii.gz $analysis_dir/$Subject
		cp $analysis_dir/$Subject/$TP/rsfMRI_2/rsfMRI_2_Mask.nii.gz $analysis_dir/$Subject


	fi

fi


done
