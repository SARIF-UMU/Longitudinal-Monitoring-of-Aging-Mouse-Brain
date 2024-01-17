# NOTE: produces error if not TP or Session 1/2 present
#! /bin/bash

cd $analysis_dir

ls -d * > sub_scan_list.txt

for t in `cat $analysis_dir/sub_scan_list.txt`;

do
	Subject=${t:0:7}

	cd $analysis_dir/$Subject

	echo "Removing first 5 scans."

	fslroi $Sess_1 $Sess_1 4 415

	echo "Slice Timing Correction for $Subject"

	echo "Session 1"

	slicetimer -i $Sess_1 -o STC_Sess_1 -r 1.5 --odd & #--ocustom=$base_path/stc_order.txt

	if [ -f $Sess_2 ]; then

		echo "Removing first 5 scans ."

		fslroi $Sess_2 $Sess_2 4 415

		echo "Session 2"
		slicetimer -i $Sess_2 -o STC_Sess_2 -r 1.5 --odd & #--ocustom=$base_path/stc_order.txt

	fi

done

echo "Slice Timing Correction Finished!"
