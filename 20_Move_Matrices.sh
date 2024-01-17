#! /bin/bash


Mat="$results_dir"/Matrices/Mat
Nii="$results_dir"/Matrices/Nii
Sess="$results_dir"/Final_Sessions
Comb_Mat="$results_dir"/Matrices/Comb_Mat
Comb_Nii="$results_dir"/Matrices/Comb_Nii

# Create sub directories
mkdir -p "$Mat" "$Nii" "$Sess" "$Comb_Nii" "$Comb_Mat"


# Move Final Sessions
for gz in "$results_dir"/*.nii.gz; do

	mv "$gz" "$Sess"
	echo "Moving $gz to $Sess..."
done

# Move Matrices - Mat
for mat in "$results_dir"/*Sess*.mat; do

	mv "$mat" "$Mat"
	echo "Moving $mat to $Mat..."
done

# Move Matrices - Nii
for nii in "$results_dir"/*Sess*.nii; do

	mv "$nii" "$Nii"
	echo "Moving $nii to $Nii..."
done

# Move Combined Matrices - Mat
for mat in "$results_dir"/*CorrMat.mat; do

	mv "$mat" "$Comb_Mat"
	echo "Moving $mat to $Comb_Mat..."
done

# Move Combined Matrices - Nii
for nii in "$results_dir"/*CorrMat.nii; do

	mv "$nii" "$Comb_Nii"
	echo "Moving $nii to $Comb_Nii..."
done
echo "Finished moving matrices."