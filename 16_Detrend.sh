#! /bin/bash

Legendre=$1

echo "Detrending with -polort $Legendre:"

for t in `cat $analysis_dir/sub_scan_list.txt`;

do

	Subject=${t:0:7}

	cd $analysis_dir/$Subject

	echo "Subject $Subject"
	echo "Session 1"

	3dDetrend -polort "$Legendre" -prefix Func_Detrend_Sess_1.nii.gz Filtered_Func_Sess_1.nii.gz

	if [ -f "Filtered_Func_Sess_2.nii.gz" ]; then
		
		echo "Session 2"

		3dDetrend -polort "$Legendre" -prefix Func_Detrend_Sess_2.nii.gz Filtered_Func_Sess_2.nii.gz
	fi


done