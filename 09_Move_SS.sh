#! /bin/bash

for s in `cat $analysis_dir/sub_scan_list.txt` ; do

subj=${s:5:5}
months=${s:17:2}

mkdir -p "$report_dir"/"$s"


rsfMRI_1_moco="$analysis_dir"/"$s"/rsfMRI_1/MoCo_Report.png
rsfMRI_1_SS="$analysis_dir"/"$s"/rsfMRI_1/"$subj"_"$months"_rsfMRI_1_brain_masked.png


report_rsfMRI_1_moco="$report_dir"/"$subj"_"$months"_rsfMRI_1_MoCo_Report.png
report_rsfMRI_1_SS="$report_dir"/"$subj"_"$months"_rsfMRI_1_SS.png


if [ -f $rsfMRI_1_moco ]; then
	if [ -f $report_rsfMRI_1_moco ]; then
		cp "$rsfMRI_1_moco" "$report_dir"/"$subj"_"$months"_rsfMRI_2_MoCo_Report.png
	fi
cp "$rsfMRI_1_moco" "$report_dir"/"$subj"_"$months"_rsfMRI_1_MoCo_Report.png
fi

if [ -f $rsfMRI_1_SS ]; then
	if [ -f $report_rsfMRI_1_SS ]; then
		cp "$rsfMRI_1_SS" "$report_dir"/"$subj"_"$months"_rsfMRI_2_SS.png
	fi
cp "$rsfMRI_1_SS" "$report_dir"/"$subj"_"$months"_rsfMRI_1_SS.png
fi


rsfMRI_2_moco="$analysis_dir"/"$s"/rsfMRI_2/MoCo_Report.png
rsfMRI_2_SS="$analysis_dir"/"$s"/rsfMRI_2/"$subj"_"$months"_rsfMRI_2_brain_masked.png


if [ -f $rsfMRI_2_moco ]; then
cp "$rsfMRI_2_moco" "$report_dir"/"$subj"_"$months"_rsfMRI_2_MoCo_Report.png
fi

if [ -f $rsfMRI_2_SS ]; then 
cp "$rsfMRI_2_SS" "$report_dir"/"$subj"_"$months"_rsfMRI_2_SS.png
fi


done
