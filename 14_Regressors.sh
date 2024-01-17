#! /bin/bash


WM_Mask=/mnt/Data/Projects/Aging_FC/Scripts/Atlas/GrandJean/WM_Mask.nii.gz
VEN_Mask=/mnt/Data/Projects/Aging_FC/Scripts/Atlas/GrandJean/VEN_Mask.nii.gz


echo "Getting WM-VEN regressors and combining with motion for:"

for t in `cat $analysis_dir/sub_scan_list.txt`;

do

	Subject=${t:0:7}

	cd $analysis_dir/$Subject

	echo " Subject $Subject"
	echo "Session 1"

	# Extract WM & VEN timeseries
	fslmeants -i $Sess_1_Reg -m $WM_Mask -o WM_ts_Sess_1.txt
	fslmeants -i $Sess_1_Reg -m $VEN_Mask -o VEN_ts_Sess_1.txt 

	# Clean, Concat CSV files
	#McFLirt
	csvtool -t SPACE -u ',' cat STC_MC_Sess_1.par -o MC_Sess_1.csv
	csvtool trim r MC_Sess_1.csv > Trimmed_MC_Sess_1.csv

	#fsl_motion_outliers
	csvtool -t SPACE -u ',' cat Sess_1_Motion_Outliers.txt -o MO_Sess_1.csv
	csvtool trim r MO_Sess_1.csv > Trimmed_MO_Sess_1.csv

	# Combine WM & VEN regressors
	csvtool -u ',' paste WM_ts_Sess_1.txt VEN_ts_Sess_1.txt -o Mask_Regressors_Sess_1.csv

	# Combine Motion regressors
	csvtool -u ',' paste Trimmed_MC_Sess_1.csv Trimmed_MO_Sess_1.csv -o Motion_Regressors_Sess_1.csv

	# Combine all regressors to csv
	csvtool -u TAB paste Motion_Regressors_Sess_1.csv Mask_Regressors_Sess_1.csv -o Regressors_Sess_1_Final.csv

	# Convert CSV to GLM MAT
	Text2Vest Regressors_Sess_1_Final.csv Regressors_Sess_1.mat

	if [ -f $Sess_2 ]; then

		echo "Session 2"

		fslmeants -i $Sess_2_Reg -m $WM_Mask -o WM_ts_Sess_2.txt
		fslmeants -i $Sess_2_Reg -m $VEN_Mask -o VEN_ts_Sess_2.txt 

		# Clean, Concat CSV files
		#McFLirt
		csvtool -t SPACE -u ',' cat STC_MC_Sess_2.par -o MC_Sess_2.csv
		csvtool trim r MC_Sess_2.csv > Trimmed_MC_Sess_2.csv

		#fsl_motion_outliers
		csvtool -t SPACE -u ',' cat Sess_2_Motion_Outliers.txt -o MO_Sess_2.csv
		csvtool trim r MO_Sess_2.csv > Trimmed_MO_Sess_2.csv

		# Combine WM & VEN regressors
		csvtool -u ',' paste WM_ts_Sess_2.txt VEN_ts_Sess_2.txt -o Mask_Regressors_Sess_2.csv

		# Combine Motion regressors
		csvtool -u ',' paste Trimmed_MC_Sess_2.csv Trimmed_MO_Sess_2.csv -o Motion_Regressors_Sess_2.csv

		# Combine all regressors to csv
		csvtool -u TAB paste Motion_Regressors_Sess_2.csv Mask_Regressors_Sess_2.csv -o Regressors_Sess_2_Final.csv

		# Convert CSV to GLM MAT
		Text2Vest Regressors_Sess_2_Final.csv Regressors_Sess_2.mat
	fi

done