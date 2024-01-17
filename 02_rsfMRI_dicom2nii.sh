#! /bin/bash


cd $data_dir

for t in */rsfMRI*;
do

echo "Converting $t"
dcm2niix n -f %i -o "$t" "$t" &> /dev/null

done

echo -e "\n"
echo "rsfMRI nifti conversion finished!"
echo -e "\n"