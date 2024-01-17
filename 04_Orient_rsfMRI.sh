#! /bin/bash

#***************
#Fix orientation
#***************



for n in "$analysis_dir"/*/*/*/rsfMRI_1.nii;

do



arr=$(fslorient -getsform "$n")

			IFS=' ' read -r -a array <<< "$arr"


					array[12]=${array[4]}
					array[13]=${array[5]}
					array[14]=${array[6]}
					array[15]=${array[7]}

					array[4]=${array[8]}
					array[5]=${array[9]}
					array[6]=${array[10]}
					array[7]=${array[11]}

					array[8]=${array[12]}
					array[9]=${array[13]}
					array[10]=${array[14]}
					array[11]=${array[15]}

					array[12]=0
					array[13]=0
					array[14]=0
					array[15]=1

					array[8]=$(echo ${array[8]}*-1 | bc)
					array[9]=$(echo ${array[9]}*-1 | bc)
					array[10]=$(echo ${array[10]}*-1 | bc)
					array[11]=$(echo ${array[11]}*-1 | bc)


			fslorient -setsform ${array[@]} "$n"
			fslorient -copysform2qform "$n"

			echo -e "Reorienting rsfMRI_1 data to standart FSL convention\n"

			fslreorient2std "$n" "$n"

			fslorient -forceneurological "$n".gz

			rm "$n"

			echo -e "Done!"


done


for n2 in "$analysis_dir"/*/*/*/rsfMRI_2.nii;

do



arr=$(fslorient -getsform "$n2")

			IFS=' ' read -r -a array <<< "$arr"


					array[12]=${array[4]}
					array[13]=${array[5]}
					array[14]=${array[6]}
					array[15]=${array[7]}

					array[4]=${array[8]}
					array[5]=${array[9]}
					array[6]=${array[10]}
					array[7]=${array[11]}

					array[8]=${array[12]}
					array[9]=${array[13]}
					array[10]=${array[14]}
					array[11]=${array[15]}

					array[12]=0
					array[13]=0
					array[14]=0
					array[15]=1

					array[8]=$(echo ${array[8]}*-1 | bc)
					array[9]=$(echo ${array[9]}*-1 | bc)
					array[10]=$(echo ${array[10]}*-1 | bc)
					array[11]=$(echo ${array[11]}*-1 | bc)


			fslorient -setsform ${array[@]} "$n2"
			fslorient -copysform2qform "$n2"

			echo -e "Reorienting rsfMRI_2 data to standart FSL convention\n"

			fslreorient2std "$n2" "$n2"

			fslorient -forceneurological "$n2".gz

			rm "$n2"

			echo -e "Done!"


done
