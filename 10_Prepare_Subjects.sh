#! /bin/bash
# 020623 FS made changes (lines 42 onward on)

#################################
#Remove scans without rsfMRI data
#################################

cd $analysis_dir
ls -d */*  > sub_scan_list.txt

echo "Getting Analysis Folder Ready..."

# for t in `cat $analysis_dir/sub_scan_list.txt`;
# do

# scan=${t:0:16}

# if ! [ -d "$t"/rsfMRI_1 ]; then
# 	rm -r "$scan"
# fi

# done



#################################
#Merge subjects scans for all TPs
#################################


for t in `cat $analysis_dir/sub_scan_list.txt`;

do

ID=${t:5:7}
TP=${t:17:2}

if ! [ -d $analysis_dir/$ID/$TP ] && [ -d $analysis_dir/$t/rsfMRI_1 ]; then
	mkdir -p $analysis_dir/$ID/$TP
	cp -R $analysis_dir/$t $analysis_dir/$ID
else
	if [ -d $analysis_dir/$ID/$TP/rsfMRI_1 ] && [ -d $analysis_dir/$t/rsfMRI_1 ]; then
		cp $analysis_dir/$t/rsfMRI_1/*.* $analysis_dir/$ID/$TP/rsfMRI_1/
		if [ -d $analysis_dir/$t/rsfMRI_2 ]; then
			mkdir -p $analysis_dir/$ID/$TP/rsfMRI_2
			cp $analysis_dir/$t/rsfMRI_2/*.* $analysis_dir/$ID/$TP/rsfMRI_2/
		fi
	fi
fi

org_folder=${t:0:16}
rm -r "$analysis_dir"/"$org_folder"

done
