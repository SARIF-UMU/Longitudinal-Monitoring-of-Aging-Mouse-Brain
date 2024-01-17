#! /bin/bash


for t in `cat $analysis_dir/sub_scan_list.txt`;

do
	Subject=${t:0:7}

	cd $analysis_dir/$Subject

	if [ -f $Sess_1 ]; then

	echo "Extracting motion parameters for Subject $Subject"
	echo "Session 1"

	#Apply brain mask and resample
	fslmaths rsfMRI_1_Mask.nii.gz -thr 0.6 -bin rsfMRI_1_Mask.nii.gz

	fslmaths "$Sess_1" -mas rsfMRI_1_Mask.nii.gz "$Sess_1_Brain"

	fslchpixdim $Sess_1_Brain 3 4 3


	fsl_motion_outliers -i "$Sess_1_Brain" -o Sess_1_Motion_Outliers.txt -p Sess_1_Motion_Outliers_Plot -s MO_Metrics_Sess_1.txt

	mcflirt -in "$Sess_1_Brain" -o STC_MC_Sess_1 -plots 

	fsl_tsplot -i STC_MC_Sess_1.par -t 'MCFLIRT estimated rotations (radians)' -u 1 --start=1 --finish=3 -a x,y,z -w 640 -h 144 -o STC_MC_Sess_1_Rotation.png
	fsl_tsplot -i STC_MC_Sess_1.par -t 'MCFLIRT estimated translations (mm)' -u 1 --start=4 --finish=6 -a x,y,z -w 640 -h 144 -o STC_MC_Sess_1_Translation.png

	echo "Detecting motion outliers..."

	fi	 


	if [ -f $Sess_2 ]; then
		echo "Session 2"

		#Apply brain mask and resample
		fslmaths rsfMRI_2_Mask.nii.gz -thr 0.6 -bin rsfMRI_2_Mask.nii.gz

		fslmaths "$Sess_2" -mas rsfMRI_2_Mask.nii.gz "$Sess_2_Brain"

		fslchpixdim $Sess_2_Brain 3 4 3

		fsl_motion_outliers -i $Sess_2_Brain -o Sess_2_Motion_Outliers.txt -p Sess_2_Motion_Outliers_Plot -s MO_Metrics_Sess_2.txt

		mcflirt -in $Sess_2_Brain -o STC_MC_Sess_2 -plots

		fsl_tsplot -i STC_MC_Sess_2.par -t 'MCFLIRT estimated rotations (radians)' -u 1 --start=1 --finish=3 -a x,y,z -w 640 -h 144 -o STC_MC_Sess_2_Rotation.png
		fsl_tsplot -i STC_MC_Sess_2.par -t 'MCFLIRT estimated translations (mm)' -u 1 --start=4 --finish=6 -a x,y,z -w 640 -h 144 -o STC_MC_Sess_2_Translation.png

		echo "Detecting motion outliers..."

	fi


done

echo "Extracted all subjects parameters."