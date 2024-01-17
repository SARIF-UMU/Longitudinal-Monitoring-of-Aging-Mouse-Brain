#! /bin/bash


for t in `cat $analysis_dir/sub_scan_list.txt`;

do

	Subject=${t:0:7}

	cd $analysis_dir/$Subject

	echo "Moving sessions for Subject $Subject"


	if [ -f "Func_Smooth_Final_Sess_2.nii.gz" ]; then
		
		echo "Found 2 sessions for $Subject, moving"

		cp Func_Smooth_Final_Sess_1.nii.gz  $results_dir/"$Subject"_Func_Sess_1.nii.gz
		cp Func_Smooth_Final_Sess_2.nii.gz  $results_dir/"$Subject"_Func_Sess_2.nii.gz
	else

		echo "Found 1 sessions for $Subject,  moving..."


		cp Func_Smooth_Final_Sess_1.nii.gz  $results_dir/"$Subject"_Func_Sess_1.nii.gz

	fi

done


# Check if any invalid session is present and remove

echo "Checking for invalid sessions and removing them..."

for chk in "$results_dir"/*.nii.gz; do

sess_size=$(stat -c %s "$chk")

if (( $sess_size < 5000000 )); then
	echo "$chk is invalid, removing..."
	rm "$sess_size"
fi



done


echo "All finished!"