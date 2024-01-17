#! /bin/bash

sigma=$1

for t in `cat $analysis_dir/sub_scan_list.txt`;

do

	Subject=${t:0:7}

	cd $analysis_dir/$Subject

	echo "Smoothing Subject $Subject with sigma $sigma"
	echo "Session 1"

	fslmaths Func_Bandpass_Sess_1.nii.gz -kernel gauss "$sigma" -fmean Func_Smooth_Final_Sess_1.nii.gz

	if [ -f "Func_Bandpass_Sess_2.nii.gz" ]; then
		
		echo "Session 2"

		fslmaths Func_Bandpass_Sess_2.nii.gz -kernel gauss "$sigma" -fmean Func_Smooth_Final_Sess_2.nii.gz
	fi


done

echo "All finished!"