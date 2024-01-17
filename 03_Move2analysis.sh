#! /bin/bash

cd $data_dir
ls -d */* > list.txt
ls -d */T1*/*.nii > T1_list.txt

T1_size=1000000

for s in `cat $data_dir/list.txt` ; 

do

modality=${s:20:3}
sub_id=${s:0:10}
TP=${s:11:2}
gender_age=${s:14:5}
rsname=${s:20:8}



echo "modality: $modality"
echo "sub_id: $sub_id"
echo "TP: $TP"
echo "gender_age: $gender_age"
echo "rsname: $rsname"


if [[ "$modality" == "rsf" ]]; 
then
	
	if ! [ -d "$analysis_dir"/"$sub_id"_"$gender_age"/"$TP"/"$rsname" ];
	then
		mkdir -p "$analysis_dir"/"$sub_id"_"$gender_age"/"$TP"/"$rsname"
		cp "$data_dir"/"$s"/*.nii "$analysis_dir"/"$sub_id"_"$gender_age"/"$TP"/"$rsname"/"$rsname".nii
		echo "rsfMRI data copied!"
	else
		echo "ERROR: $TP already exists in the folder!!!"
	fi
fi

done




for t in `cat $data_dir/T1_list.txt` ; 

do


sub_id=${t:0:10}
TP=${t:11:2}
gender_age=${t:14:5}




	#T1_image=$t
	T2_image="$data_dir"/"$t"
	echo "$T2_image"
	T2_size=$(stat -c %s "$T2_image")
	if (( T2_size > T1_size ));
	then
	mkdir -p "$analysis_dir"/"$sub_id"_"$gender_age"/"$TP"/T1
	cp "$T2_image" "$analysis_dir"/"$sub_id"_"$gender_age"/"$TP"/T1/T1.nii
	fi

 done