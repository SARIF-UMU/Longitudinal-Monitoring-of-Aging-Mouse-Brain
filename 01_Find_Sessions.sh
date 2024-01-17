#! /bin/bash

Month1=$1
Month2=$2

Subj_Num=1

cd $orig_dir

ls -d */ | cut -f1 -d'/'  > list.txt


for t in `cat $orig_dir/list.txt`;
do

# Check key file for unique name and find matching covars
	key_file="$script_dir/Bruker_Key.csv"
	seek="$t"
	while IFS=, read Folder	Scan_date	TP	Gender	DOB	ID	Days	Group	Strain	Sub_Strain	Anesthesia; do
	    if [[ $Folder == "$seek" ]] && [[ $TP -gt 5 ]]; then
			#Changed by FS on 010623
				#if [[ $Folder == "$seek" ]] && (($TP >= $Month1 && $TP <= $Month2)) ; then

	        ID=$ID
	        TP=`printf %02d $TP`
	        Gender=$Gender
	        Scan_Date=$Scan_Date
	        DOB=$DOB
	        Age=$Days
	        Bruker_ID=$Bruker_ID








echo -e "\n"
echo "********************"
echo "Subject Number: $Subj_Num "
echo "********************"
echo "Subject ID: $ID"
echo "Months: $TP"
echo "Gender : $Gender"
echo "DOB: $DOB"
echo "Scan date: $Scan_date"
echo "Age in days: $Age"



found=0
#Find sessions
cd $orig_dir/$t

ls -d */ | cut -f1 -d'/' > scan_list.txt

for s in `cat $orig_dir/$t/scan_list.txt`;

do



	if [ -d "$orig_dir/$t/$s/pdata/1/dicom" ];
	then
		cd $orig_dir/$t/$s/pdata/1/dicom
		dicom_num=$(ls *.dcm | wc -l)

		if (( 60 < $dicom_num )) && (( $dicom_num < 65 ));
		then
			echo "Subject `printf %04d $Subj_Num`  / $TP months / scan $s has Potential T1"
			mkdir -p $data_dir/"`printf %04d $Subj_Num`"_"$ID"_"$TP"_"$Gender"_"`printf %03d $Age`"/T1_"$s"/
			rsync -a $orig_dir/$t/$s/pdata/1/ $data_dir/"`printf %04d $Subj_Num`"_"$ID"_"$TP"_"$Gender"_"`printf %03d $Age`"/T1_"$s"
			found=1

		elif (( 15900 < $dicom_num )) && (( $dicom_num < 16000 )) && [ -d $data_dir/"`printf %04d $Subj_Num`"_"$ID"_"$TP"_"$Gender"_"`printf %03d $Age`"/rsfMRI_1 ];
		then
			echo "Subject `printf %04d $Subj_Num` / $TP months / scan $s has Potential rsfMRI_2"
			mkdir -p $data_dir/"`printf %04d $Subj_Num`"_"$ID"_"$TP"_"$Gender"_"`printf %03d $Age`"/rsfMRI_2/
			rsync -a $orig_dir/$t/$s/pdata/1/ $data_dir/"`printf %04d $Subj_Num`"_"$ID"_"$TP"_"$Gender"_"`printf %03d $Age`"/rsfMRI_2
			found=1

		elif (( 15900 < $dicom_num )) && (( $dicom_num < 16000 )) && ! [ -d $data_dir/"`printf %04d $Subj_Num`"_"$ID"_"$TP"_"$Gender"_"`printf %03d $Age`"/rsfMRI_1 ] ;
		then
			echo "Subject `printf %04d $Subj_Num` / $TP months / scan $s has Potential rsfMRI_1"
			mkdir -p $data_dir/"`printf %04d $Subj_Num`"_"$ID"_"$TP"_"$Gender"_"`printf %03d $Age`"/rsfMRI_1/
			rsync -a $orig_dir/$t/$s/pdata/1/ $data_dir/"`printf %04d $Subj_Num`"_"$ID"_"$TP"_"$Gender"_"`printf %03d $Age`"/rsfMRI_1
			found=1

		fi

	fi

done

if [[ $found == "1" ]]; then



	((Subj_Num=Subj_Num+1))

else
	#If not found write to Missing_Scan file
	if [ -f $script_dir/Missing_Scans.csv ];
	then
	echo -e "$t" >> $script_dir/Missing_Scans.csv
		else
	echo -e "$t" > $script_dir/Missing_Scans.csv
	fi

fi

fi

done < "$key_file"

done
