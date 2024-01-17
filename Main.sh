#! /bin/bash
####################################################
# !!!!!!!!HOWTO/README 1st
# A: Run script 01-10_Prepare_Subjects.sh before continuing
#     In 001_Find_Sessions adjust age range/TP selections
# B: For each TP run 10_Prepare_TP till/include 21_Backup_Analysis as group
#       before continuing with next TP
# !!!!!!!Otherwise results will be overwritten before backup to TP folder
# C: FINALLY move output in Results/XXX/Finall Sessions etc
#       to TP folder Results/XXX/TP/Finall Sessions etc
####################################################

#Define Analysis Name (ie: Date)
#Analysis_Name=15Dec
#Analysis_Name=05Aug
#Analysis_Name=YMiddle_2_VOld
#Analysis_Name=Middle_2_Old #higpass and quadratic detrending
#Analysis_Name=Middle_2_Old_BP #bandpass filter 0.01-0.08
Analysis_Name=Middle_2_Old_lin #with linear detrending

# Define folders
base_path=/mnt/Data/Projects/Aging_FC
orig_dir=$base_path/Orig/
script_dir=$base_path/Scripts
data_dir=$base_path/Data/$Analysis_Name
analysis_dir=$base_path/Analysis/$Analysis_Name
results_dir=$base_path/Results/$Analysis_Name/
stats_dir=$base_path/Stats/$Analysis_Name
report_dir=$base_path/Reports/$Analysis_Name
template_dir=$results_dir/Template

#Define some filenames

Sess_1=rsfMRI_1.nii.gz
Sess_2=rsfMRI_2.nii.gz

Sess_1_Brain=rsfMRI_1_Brain.nii.gz
Sess_2_Brain=rsfMRI_2_Brain.nii.gz

Sess_1_Reg=rsfMRI_1_Brain_Reg.nii.gz
Sess_2_Reg=rsfMRI_2_Brain_Reg.nii.gz



#############################################
# * 01) Find sessions and move to Data folder
#############################################
#
#  source $script_dir/01_Find_Sessions.sh
#
# ########################
# # * 02) Nifti conversion
# ########################
#
#  cd $script_dir
#
# #T1 data conversion
#  source $script_dir/02_T1_dicom2nii.sh
#
# #rsfMRI data conversion
#  source $script_dir/02_rsfMRI_dicom2nii.sh
#
# ####################################
# # * 03) Move data to Analysis folder
# ####################################
#
#  source $script_dir/03_Move2analysis.sh
#
# ##############################
# # * 04) Fix Orientation issues
# ##############################
#
# # Orient T1 data
#  source $script_dir/04_Orient_T1.sh
#
# # Orient rsfMRI data
#  source $script_dir/04_Orient_rsfMRI.sh
#
# #############################
# # * 05) Bias Field Correction
# #############################
#
#  source $script_dir/05_Bias_Correction_T1.sh
#
# ############################
# # * 06) Skullstrip T1 images
# ############################
#
#  source $script_dir/06_Skullstrip_T1.sh
#
# ##############################################################
# # * 07) Inter-modality registration and brain mask application
# ##############################################################
#
# # T1 <-> T2
#  source $script_dir/07_T1_T2_Reg.sh
#
#
# ##########################
# # * 08) Preprocess T2 data
# ##########################
#
# # MCFLIRT on brain extracted rsfMRI data
#  source $script_dir/08_rsfMRI_mcflirt.sh
#  parallel -j 8 < $script_dir/logs/08_mcflirt.txt
#  source $script_dir/08_rsfMRI_moco.sh
#
#
# ###################################################
# # * 09) Generate QC Screenshots & Move to QC folder
# ###################################################
#
# # Screenshots for rsfMRI data
#  source $script_dir/09_SS_rsfMRI.sh
#
# # Move screenshots to Report folder
#  source $script_dir/09_Move_SS.sh > $report_dir/errors.txt

#######################
#END OF QUALITY CONTROL
#######################


#############################
# * 10) Prepare Subjects & TP
#############################

# Run this part only ONCE for each project!!!
# Copy Project folder "up to 10 step" in ANALYSIS to new project
# source $script_dir/10_Prepare_Subjects.sh
#
#
# TP to be analysed in months (06,12,18,24,26)
  source $script_dir/10_Prepare_TP.sh 18
#
# ####################################################
# # * 11) Slice Timing Corr & Removal of first 5 scans
# ####################################################
#
# # Default is --odd , Interleaved
  source $script_dir/11_STC.sh
#
###########################
# * 12) Motion Corr & Plots
###########################

 source $script_dir/12_Mo_Corr.sh

####################################
# * 13) Registration to  GJ Template
####################################

 source $script_dir/13_Reg2GJ_Template.sh

###############################################################
# * 14) Extract WM timeseries and combine with other regressors
###############################################################

 source $script_dir/14_Regressors.sh

############################################
# * 15) Regress out WM and Motion Parameters
############################################

 source $script_dir/15_Regress_Out.sh

#################
# 16) Detrending
#################

# Set -polort arg.1_Linear, 2:Lin+Quad, 3:Lin+Quad+Cub
# source $script_dir/16_Detrend.sh 2 # original, pre823
 source $script_dir/16_Detrend.sh 1

#######################
# * 17) High-Pass Filter
#######################

# Define LOW and HIGH freq thresholds for band-pass filter (default:0.01 99999 - only High-pass)
# source $script_dir/17_Filter.sh 0.01 99999
# source $script_dir/17_Filter.sh 0.01 0.08 # for BP
  source $script_dir/17_Filter.sh 0.01 99999



#################
# * 18) Smoothing
#################

# Define sigma for Gaussian smoothing (default: 0.26 ~ 0.6mm)
 source $script_dir/18_Smooth.sh 0.26

####################
# * XX) Seed analysis could continue from here
####################

####################
# * 19) Move Results
####################

 source $script_dir/19_Move_Results.sh

############################
# * 20) Timeseries Correlation
############################

 cd $script_dir

 matlab -nodisplay -nosplash -nodesktop -r "correlate_ts('$results_dir');exit;"
 matlab -nodisplay -nosplash -nodesktop -r "combine_ts('$results_dir');exit;"

 cd $script_dir
 source $script_dir/20_Move_Matrices.sh

######################
#* 21) Backup Analysis
######################

 source $script_dir/21_Backup_Analysis.sh
# Move final Results outputs to TP (12/18/24) subfolders

# #####################################
# * 22) Tissue classification with FAST
# #####################################
#
# source 026_FAST.sh
