#! /bin/bash


cd $data_dir

for t in */T1*;
do

echo "Converting $t"
dcm2niix n  -f %i -o "$t" "$t" &> /dev/null

done

echo -e "\n"
echo "T1 nifti conversion finished!"
echo -e "\n"
