#!/bin/bash

#SBATCH --ntasks=24	#cpu usage
#SBATCH --gres=gpu:4
#SBATCH --time=04:00:00  #walltime
#SBATCH --exclusive
#SBATCH --mem-per-cpu=2048M  #memory per CPU core
#SBATCH --qos=test

#this line loads the CUDA library which is needed for the GPUs
module load cuda/6.5.14

###########################################################################-----------1
echo "Begin 0 0 0 origin"

##-------Construct GB--------##
time mpirun /fslhome/dadams26/executables/lmp_gpu_NVsv\
	-log /fslhome/dadams26/log_output/Ta_Test_GBmin.log\
	-in /fslhome/dadams26/lammps_scripts/Ta_Test_GBmin.in\
	-var dumpname1 "AATa_Test_GBmin_*.out"\
#	-var dumpname9 "zdump.Ta_Test_unfiltered_*.out"\
	-var restartname1 "Ta_Test_GB.restart"\
	-var a 0.5\
	-var b 0.5\
	-var c 0\
	-var cutoff 0.677\
	-sf gpu  -pk gpu 4

##-----Equilibrate Ta GB----##
time mpirun /fslhome/dadams26/executables/lmp_gpu_NVsv\
	-log /fslhome/dadams26/log_output/Ta_Test_equil.log\
	-in /fslhome/dadams26/lammps_scripts/Ta_Test_Equil.in\
	-var restartname1 "Ta_Test_GB.restart"\
	-var dumpname2 "AATaD_Test_Equil550_*.out"\
	-var restartname2 "Ta_Test_equil.restart"\
	-sf gpu  -pk gpu 4

##-----Shear Ta GB----##
time mpirun /fslhome/dadams26/executables/lmp_gpu_NVsv\
	-log /fslhome/dadams26/log_output/Ta_Test_shear.log\
	-in /fslhome/dadams26/lammps_scripts/Ta_Test_Shear.in\
	-var restartname2 "Ta_Test_equil.restart"\
	-var dumpname3 "AAdump.Ta5_Test_Shear_TB8000_*.out"\
	-var dumpname4 "AAdump.Ta5_Test_Shearunfiltered_TB8000_*.out"\
	-var restartname3 "Ta_Test_shear.restart"\
	-sf gpu  -pk gpu 4

echo "End 0 0 0 origin"
