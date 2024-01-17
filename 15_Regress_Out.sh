#! /bin/bash

echo "Regressing out parameters for:"

for t in `cat $analysis_dir/sub_scan_list.txt`;

do

	Subject=${t:0:7}

	cd $analysis_dir/$Subject

	echo "Subject $Subject"
	echo "Session 1"

	fsl_glm -i $Sess_1_Reg -d Regressors_Sess_1.mat -o Func_Beta_Sess_1.nii.gz --out_res=Filtered_Func_Sess_1.nii.gz

	if [ -f $Sess_2 ]; then
		echo "Session 2"

		fsl_glm -i $Sess_2_Reg -d Regressors_Sess_2.mat -o Func_Beta_Sess_2.nii.gz --out_res=Filtered_Func_Sess_2.nii.gz
	fi

done

echo "Finished!"