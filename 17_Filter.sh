#! /bin/bash

Thr_Low=$1
Thr_High=$2

echo "Apply High-Pass Filter:"

for t in `cat $analysis_dir/sub_scan_list.txt`;

do

	Subject=${t:0:7}

	cd $analysis_dir/$Subject

	echo "Subject $Subject"
	echo "Session 1"

	3dBandpass -prefix Func_Bandpass_Sess_1.nii.gz -nodetrend "$Thr_Low" "$Thr_High" Func_Detrend_Sess_1.nii.gz

	if [ -f "Func_Detrend_Sess_2.nii.gz" ]; then
		
		echo "Session 2"

		3dBandpass -prefix Func_Bandpass_Sess_2.nii.gz -nodetrend "$Thr_Low" "$Thr_High" Func_Detrend_Sess_2.nii.gz
	fi

	
done