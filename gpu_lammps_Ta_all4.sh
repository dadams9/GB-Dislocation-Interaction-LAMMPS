#!/bin/bash

#SBATCH --ntasks=24	#cpu usage
#SBATCH --gres=gpu:4
#SBATCH --time=48:00:00  #walltime
#SBATCH --exclusive
#SBATCH --mem-per-cpu=2560M  #memory per CPU core
#SBATCH --qos=test
#SBATCH --mail-user=devin_adams3@hotmail.com   # email address
#SBATCH --mail-type=FAIL

#this line loads the CUDA library which is needed for the GPUs
module load cuda/6.5.14

###########################################################################-----------1
echo "Begin 5 5 0 origin - Tantalum 4"

##-------Construct GB--------##
#time mpirun /fslhome/dadams26/executables/lmp_gpu_NVsv\
#	-log /fslhome/dadams26/log_output/Ta4_550_GBmin_DA.log\
#	-in /fslhome/dadams26/lammps_scripts/Ta_GBmin_DA.in\
#	-var dumpname3gb "zdump.Ta3_550_GBmin*.out"\
#	-var dumpname4gb "zdump.Ta4_550_GBmin*.out"\
#	-var dumpname5gb "zdump.Ta5_550_GBmin*.out"\
#	-var restartname3gb "Ta3_550_GB.restart"\
#	-var restartname4gb "Ta4_550_GB.restart"\
#	-var restartname5gb "Ta5_550_GB.restart"\
#	-var Ta 4\
#	-var a 0.5\
#	-var b 0.5\
#	-var c 0\
#	-var cutoff 0.677\
#	-sf gpu  -pk gpu 4


#1:Symmetrical sharp	#2:Left sharp, right soft	#3:Right sharp, left soft
#4:Symmetrical soft	#5:Left soft, right broad	#6:Right soft, left broad 
#7:Symmetrical broad	#8:Left broad, right sharp	#9:Right broad, left sharp

##-----Equilibrate Ta GB - Notch 1-----##
#time mpirun /fslhome/dadams26/executables/lmp_gpu_NVsv\
#	-log /fslhome/dadams26/log_output/Ta4_550_Equil_DA_Ravelo2_N1.log\
#	-in /fslhome/dadams26/lammps_scripts/Ta_Equil_DA.in\
#	-var dumpname3eq "zdump.Ta3_550_Equil_Ravelo2_N1_*.out"\
#	-var dumpname4eq "zdump.Ta4_550_Equil_Ravelo2_N1_*.out"\
#	-var dumpname5eq "zdump.Ta5_550_Equi_Ravelo2l_N1_*.out"\
#	-var restartname3gb "Ta3_550_GB_Ravelo2.restart"\
#	-var restartname4gb "Ta4_550_GB_Ravelo2.restart"\
#	-var restartname5gb "Ta5_550_GB_Ravelo2.restart"\
#	-var restartname3eq "Ta3_550_Eq_Ravelo2_N1.restart"\
#	-var restartname4eq "Ta4_550_Eq_Ravelo2_N1.restart"\
#	-var restartname5eq "Ta5_550_Eq_Ravelo2_N1.restart"\
#	-var Ta 4\
#	-var a 0.5\
#	-var b 0.5\
#	-var c 0\
#	-var notchshape 1\			
#	-var cutoff 0.677\
#	-sf gpu  -pk gpu 4

##-----Shear Ta GB - Notch 1-----##
#time mpirun /fslhome/dadams26/executables/lmp_gpu_NVsv\
#	-log /fslhome/dadams26/log_output/Ta4_550_Shear_DA_Ravelo2_N1.log\
#	-in /fslhome/dadams26/lammps_scripts/Ta_Shear_DA.in\
#	-var dumpname3sh "zdump.Ta3_550_Shear_Ravelo2_N1_*.out"\
#	-var dumpname4sh "zdump.Ta4_550_Shear_Ravelo2_N1_*.out"\
#	-var dumpname5sh "zdump.Ta5_550_Shear_Ravelo2_N1_*.out"\
#	-var dumpname3bsh "zdump.Ta3_550_Shear_unfiltered_Ravelo2_N1_*.out"\
#	-var dumpname4bsh "zdump.Ta4_550_Shear_unfiltered_Ravelo2_N1_*.out"\
#	-var dumpname5bsh "zdump.Ta5_550_Shear_unfiltered_Ravelo2_N1_*.out"\
#	-var restartname3eq "Ta3_550_Eq_Ravelo2_N1.restart"\
#	-var restartname4eq "Ta4_550_Eq_Ravelo2_N1.restart"\
#	-var restartname5eq "Ta5_550_Eq_Ravelo2_N1.restart"\
#	-var restartname3sh "Ta3_550_Sh_Ravelo2_N1.restart"\
#	-var restartname4sh "Ta4_550_Sh_Ravelo2_N1.restart"\
#	-var restartname5sh "Ta5_550_Sh_Ravelo2_N1.restart"\
#	-var Ta 4\
#	-var a 0.5\
#	-var b 0.5\
#	-var c 0\
#	-var cutoff 0.677\
#	-sf gpu  -pk gpu 4

##-----Equilibrate Ta GB - Notch 2-----##
#time mpirun /fslhome/dadams26/executables/lmp_gpu_NVsv\
#	-log /fslhome/dadams26/log_output/Ta4_550_Equil_DA_N2.log\
#	-in /fslhome/dadams26/lammps_scripts/Ta_Equil_DA.in\
#	-var dumpname3eq "zdump.Ta3_550_Equil_N2_*.out"\
#	-var dumpname4eq "zdump.Ta4_550_Equil_N2_*.out"\
#	-var dumpname5eq "zdump.Ta5_550_Equil_N2_*.out"\
#	-var restartname3gb "Ta3_550_GB.restart"\
#	-var restartname4gb "Ta4_550_GB.restart"\
#	-var restartname5gb "Ta5_550_GB.restart"\
#	-var restartname3eq "Ta3_550_Eq_N2.restart"\
#	-var restartname4eq "Ta4_550_Eq_N2.restart"\
#	-var restartname5eq "Ta5_550_Eq_N2.restart"\
#	-var Ta 4\
#	-var a 0.5\
#	-var b 0.5\
#	-var c 0\
#	-var notchshape 2\			
#	-var cutoff 0.677\
#	-sf gpu  -pk gpu 4

##-----Shear Ta GB - Notch 2-----##
#time mpirun /fslhome/dadams26/executables/lmp_gpu_NVsv\
#	-log /fslhome/dadams26/log_output/Ta4_550_Shear_DA_N2.log\
#	-in /fslhome/dadams26/lammps_scripts/Ta_Shear_DA.in\
#	-var dumpname3sh "zdump.Ta3_550_Shear_N2_*.out"\
#	-var dumpname4sh "zdump.Ta4_550_Shear_N2_*.out"\
#	-var dumpname5sh "zdump.Ta5_550_Shear_N2_*.out"\
#	-var dumpname3bsh "zdump.Ta3_550_Shear_unfiltered_N2_*.out"\
#	-var dumpname4bsh "zdump.Ta4_550_Shear_unfiltered_N2_*.out"\
#	-var dumpname5bsh "zdump.Ta5_550_Shear_unfiltered_N2_*.out"\
#	-var restartname3eq "Ta3_550_Eq_N2.restart"\
#	-var restartname4eq "Ta4_550_Eq_N2.restart"\
#	-var restartname5eq "Ta5_550_Eq_N2.restart"\
#	-var restartname3sh "Ta3_550_Sh_N2.restart"\
#	-var restartname4sh "Ta4_550_Sh_N2.restart"\
#	-var restartname5sh "Ta5_550_Sh_N2.restart"\
#	-var Ta 4\
#	-var a 0.5\
#	-var b 0.5\
#	-var c 0\
#	-var cutoff 0.677\
#	-sf gpu  -pk gpu 4

##-----Equilibrate Ta GB - Notch 3-----##
#time mpirun /fslhome/dadams26/executables/lmp_gpu_NVsv\
#	-log /fslhome/dadams26/log_output/Ta4_550_Equil_DA_N3.log\
#	-in /fslhome/dadams26/lammps_scripts/Ta_Equil_DA.in\
#	-var dumpname3eq "zdump.Ta3_550_Equil_N3_*.out"\
#	-var dumpname4eq "zdump.Ta4_550_Equil_N3_*.out"\
#	-var dumpname5eq "zdump.Ta5_550_Equil_N3_*.out"\
#	-var restartname3gb "Ta3_550_GB.restart"\
#	-var restartname4gb "Ta4_550_GB.restart"\
#	-var restartname5gb "Ta5_550_GB.restart"\
#	-var restartname3eq "Ta3_550_Eq_N3.restart"\
#	-var restartname4eq "Ta4_550_Eq_N3.restart"\
#	-var restartname5eq "Ta5_550_Eq_N3.restart"\
#	-var Ta 4\
#	-var a 0.5\
#	-var b 0.5\
#	-var c 0\
#	-var notchshape 3\			
#	-var cutoff 0.677\
#	-sf gpu  -pk gpu 4

##-----Shear Ta GB - Notch 3-----##
#time mpirun /fslhome/dadams26/executables/lmp_gpu_NVsv\
#	-log /fslhome/dadams26/log_output/Ta4_550_Shear_DA_N3.log\
#	-in /fslhome/dadams26/lammps_scripts/Ta_Shear_DA.in\
#	-var dumpname3sh "zdump.Ta3_550_Shear_N3_*.out"\
#	-var dumpname4sh "zdump.Ta4_550_Shear_N3_*.out"\
#	-var dumpname5sh "zdump.Ta5_550_Shear_N3_*.out"\
#	-var dumpname3bsh "zdump.Ta3_550_Shear_unfiltered_N3_*.out"\
#	-var dumpname4bsh "zdump.Ta4_550_Shear_unfiltered_N3_*.out"\
#	-var dumpname5bsh "zdump.Ta5_550_Shear_unfiltered_N3_*.out"\
#	-var restartname3eq "Ta3_550_Eq_N3.restart"\
#	-var restartname4eq "Ta4_550_Eq_N3.restart"\
#	-var restartname5eq "Ta5_550_Eq_N3.restart"\
#	-var restartname3sh "Ta3_550_Sh_N3.restart"\
#	-var restartname4sh "Ta4_550_Sh_N3.restart"\
#	-var restartname5sh "Ta5_550_Sh_N3.restart"\
#	-var Ta 4\
#	-var a 0.5\
#	-var b 0.5\
#	-var c 0\
#	-var cutoff 0.677\
#	-sf gpu  -pk gpu 4

###-----Equilibrate Ta GB - Notch 4-----##
#time mpirun /fslhome/dadams26/executables/lmp_gpu_NVsv\
#	-log /fslhome/dadams26/log_output/Ta4_550_Equil_DA_N4.log\
#	-in /fslhome/dadams26/lammps_scripts/Ta_Equil_DA.in\
#	-var dumpname3eq "zdump.Ta3_550_Equil_N4_*.out"\
#	-var dumpname4eq "zdump.Ta4_550_Equil_N4_*.out"\
#	-var dumpname5eq "zdump.Ta5_550_Equil_N4_*.out"\
#	-var restartname3gb "Ta3_550_GB.restart"\
#	-var restartname4gb "Ta4_550_GB.restart"\
#	-var restartname5gb "Ta5_550_GB.restart"\
#	-var restartname3eq "Ta3_550_Eq_N4.restart"\
#	-var restartname4eq "Ta4_550_Eq_N4.restart"\
#	-var restartname5eq "Ta5_550_Eq_N4.restart"\
#	-var Ta 4\
#	-var a 0.5\
#	-var b 0.5\
#	-var c 0\
#	-var notchshape 4\			
#	-var cutoff 0.677\
#	-sf gpu  -pk gpu 4

##-----Shear Ta GB - Notch 4-----##
#time mpirun /fslhome/dadams26/executables/lmp_gpu_NVsv\
#	-log /fslhome/dadams26/log_output/Ta4_550_Shear_DA_N4.log\
#	-in /fslhome/dadams26/lammps_scripts/Ta_Shear_DA.in\
#	-var dumpname3sh "zdump.Ta3_550_Shear_N4_*.out"\
#	-var dumpname4sh "zdump.Ta4_550_Shear_N4_*.out"\
#	-var dumpname5sh "zdump.Ta5_550_Shear_N4_*.out"\
#	-var dumpname3bsh "zdump.Ta3_550_Shear_unfiltered_N4_*.out"\
#	-var dumpname4bsh "zdump.Ta4_550_Shear_unfiltered_N4_*.out"\
#	-var dumpname5bsh "zdump.Ta5_550_Shear_unfiltered_N4_*.out"\
#	-var restartname3eq "Ta3_550_Eq_N4.restart"\
#	-var restartname4eq "Ta4_550_Eq_N4.restart"\
#	-var restartname5eq "Ta5_550_Eq_N4.restart"\
#	-var restartname3sh "Ta3_550_Sh_N4.restart"\
#	-var restartname4sh "Ta4_550_Sh_N4.restart"\
#	-var restartname5sh "Ta5_550_Sh_N4.restart"\
#	-var Ta 4\
#	-var a 0.5\
#	-var b 0.5\
#	-var c 0\
#	-var cutoff 0.677\
#	-sf gpu  -pk gpu 4

##-----Equilibrate Ta GB - Notch 5-----##
#time mpirun /fslhome/dadams26/executables/lmp_gpu_NVsv\
#	-log /fslhome/dadams26/log_output/Ta4_550_Equil_DA_N5.log\
#	-in /fslhome/dadams26/lammps_scripts/Ta_Equil_DA.in\
#	-var dumpname3eq "zdump.Ta3_550_Equil_N5_*.out"\
#	-var dumpname4eq "zdump.Ta4_550_Equil_N5_*.out"\
#	-var dumpname5eq "zdump.Ta5_550_Equil_N5_*.out"\
#	-var restartname3gb "Ta3_550_GB.restart"\
#	-var restartname4gb "Ta4_550_GB.restart"\
#	-var restartname5gb "Ta5_550_GB.restart"\
#	-var restartname3eq "Ta3_550_Eq_N5.restart"\
#	-var restartname4eq "Ta4_550_Eq_N5.restart"\
#	-var restartname5eq "Ta5_550_Eq_N5.restart"\
#	-var Ta 4\
#	-var a 0.5\
#	-var b 0.5\
#	-var c 0\
# 	-var notchshape 5\			
#	-var cutoff 0.677\
#	-sf gpu  -pk gpu 4

##-----Shear Ta GB - Notch 5-----##
#time mpirun /fslhome/dadams26/executables/lmp_gpu_NVsv\
#	-log /fslhome/dadams26/log_output/Ta4_550_Shear_DA_N5.log\
#	-in /fslhome/dadams26/lammps_scripts/Ta_Shear_DA.in\
#	-var dumpname3sh "zdump.Ta3_550_Shear_N5_*.out"\
#	-var dumpname4sh "zdump.Ta4_550_Shear_N5_*.out"\
#	-var dumpname5sh "zdump.Ta5_550_Shear_N5_*.out"\
#	-var dumpname3bsh "zdump.Ta3_550_Shear_unfiltered_N5_*.out"\
#	-var dumpname4bsh "zdump.Ta4_550_Shear_unfiltered_N5_*.out"\
#	-var dumpname5bsh "zdump.Ta5_550_Shear_unfiltered_N5_*.out"\
#	-var restartname3eq "Ta3_550_Eq_N5.restart"\
#	-var restartname4eq "Ta4_550_Eq_N5.restart"\
#	-var restartname5eq "Ta5_550_Eq_N5.restart"\
#	-var restartname3sh "Ta3_550_Sh_N5.restart"\
#	-var restartname4sh "Ta4_550_Sh_N5.restart"\
#	-var restartname5sh "Ta5_550_Sh_N5.restart"\
#	-var Ta 4\
#	-var a 0.5\
#	-var b 0.5\
#	-var c 0\
#	-var cutoff 0.677\
#	-sf gpu  -pk gpu 4

##-----Equilibrate Ta GB - Notch 6-----##
#time mpirun /fslhome/dadams26/executables/lmp_gpu_NVsv\
#	-log /fslhome/dadams26/log_output/Ta4_550_Equil_DA_N6.log\
#	-in /fslhome/dadams26/lammps_scripts/Ta_Equil_DA.in\
#	-var dumpname3eq "zdump.Ta3_550_Equil_N6_*.out"\
#	-var dumpname4eq "zdump.Ta4_550_Equil_N6_*.out"\
#	-var dumpname5eq "zdump.Ta5_550_Equil_N6_*.out"\
#	-var restartname3gb "Ta3_550_GB.restart"\
#	-var restartname4gb "Ta4_550_GB.restart"\
#	-var restartname5gb "Ta5_550_GB.restart"\
#	-var restartname3eq "Ta3_550_Eq_N6.restart"\
#	-var restartname4eq "Ta4_550_Eq_N6.restart"\
#	-var restartname5eq "Ta5_550_Eq_N6.restart"\
#	-var Ta 4\
#	-var a 0.5\
#	-var b 0.5\
#	-var c 0\
 #	-var notchshape 6\			
#	-var cutoff 0.677\
#	-sf gpu  -pk gpu 4

##-----Shear Ta GB - Notch 6-----##
#time mpirun /fslhome/dadams26/executables/lmp_gpu_NVsv\
#	-log /fslhome/dadams26/log_output/Ta4_550_Shear_DA_N6.log\
#	-in /fslhome/dadams26/lammps_scripts/Ta_Shear_DA.in\
#	-var dumpname3sh "zdump.Ta3_550_Shear_N6_*.out"\
#	-var dumpname4sh "zdump.Ta4_550_Shear_N6_*.out"\
#	-var dumpname5sh "zdump.Ta5_550_Shear_N6_*.out"\
#	-var dumpname3bsh "zdump.Ta3_550_Shear_unfiltered_N6_*.out"\
#	-var dumpname4bsh "zdump.Ta4_550_Shear_unfiltered_N6_*.out"\
#	-var dumpname5bsh "zdump.Ta5_550_Shear_unfiltered_N6_*.out"\
#	-var restartname3eq "Ta3_550_Eq_N6.restart"\
#	-var restartname4eq "Ta4_550_Eq_N6.restart"\
#	-var restartname5eq "Ta5_550_Eq_N6.restart"\
#	-var restartname3sh "Ta3_550_Sh_N6.restart"\
#	-var restartname4sh "Ta4_550_Sh_N6.restart"\
#	-var restartname5sh "Ta5_550_Sh_N6.restart"\
#	-var Ta 4\
#	-var a 0.5\
#	-var b 0.5\
#	-var c 0\
#	-var cutoff 0.677\
#	-sf gpu  -pk gpu 4
#
##-----Equilibrate Ta GB - Notch 7-----##
#time mpirun /fslhome/dadams26/executables/lmp_gpu_NVsv\
#	-log /fslhome/dadams26/log_output/Ta4_550_Equil_DA_N7.log\
#	-in /fslhome/dadams26/lammps_scripts/Ta_Equil_DA.in\
#	-var dumpname3eq "zdump.Ta3_550_Equil_N7_*.out"\
#	-var dumpname4eq "zdump.Ta4_550_Equil_N7_*.out"\
#	-var dumpname5eq "zdump.Ta5_550_Equil_N7_*.out"\
#	-var restartname3gb "Ta3_550_GB.restart"\
#	-var restartname4gb "Ta4_550_GB.restart"\
#	-var restartname5gb "Ta5_550_GB.restart"\
#	-var restartname3eq "Ta3_550_Eq_N7.restart"\
#	-var restartname4eq "Ta4_550_Eq_N7.restart"\
#	-var restartname5eq "Ta5_550_Eq_N7.restart"\
#	-var Ta 4\
#	-var a 0.5\
#	-var b 0.5\
#	-var c 0\
 #	-var notchshape 7\			
#	-var cutoff 0.677\
#	-sf gpu  -pk gpu 4

##-----Shear Ta GB - Notch 7-----##
#time mpirun /fslhome/dadams26/executables/lmp_gpu_NVsv\
#	-log /fslhome/dadams26/log_output/Ta4_550_Shear_DA_N7.log\
#	-in /fslhome/dadams26/lammps_scripts/Ta_Shear_DA.in\
#	-var dumpname3sh "zdump.Ta3_550_Shear_N7_*.out"\
#	-var dumpname4sh "zdump.Ta4_550_Shear_N7_*.out"\
#	-var dumpname5sh "zdump.Ta5_550_Shear_N7_*.out"\
#	-var dumpname3bsh "zdump.Ta3_550_Shear_unfiltered_N7_*.out"\
#	-var dumpname4bsh "zdump.Ta4_550_Shear_unfiltered_N7_*.out"\
#	-var dumpname5bsh "zdump.Ta5_550_Shear_unfiltered_N7_*.out"\
#	-var restartname3eq "Ta3_550_Eq_N7.restart"\
#	-var restartname4eq "Ta4_550_Eq_N7.restart"\
#	-var restartname5eq "Ta5_550_Eq_N7.restart"\
#	-var restartname3sh "Ta3_550_Sh_N7.restart"\
#	-var restartname4sh "Ta4_550_Sh_N7.restart"\
#	-var restartname5sh "Ta5_550_Sh_N7.restart"\
#	-var Ta 4\
#	-var a 0.5\
#	-var b 0.5\
#	-var c 0\
#	-var cutoff 0.677\
#	-sf gpu  -pk gpu 4

##-----Equilibrate Ta GB - Notch 10-----##
#time mpirun /fslhome/dadams26/executables/lmp_gpu_NVsv\
#	-log /fslhome/dadams26/log_output/Ta4_550_Equil_DA_N10.log\
#	-in /fslhome/dadams26/lammps_scripts/Ta_Equil_DA.in\
#	-var dumpname3eq "zdump.Ta3_550_Equil_N10_*.out"\
#	-var dumpname4eq "zdump.Ta4_550_Equil_N10_*.out"\
#	-var dumpname5eq "zdump.Ta5_550_Equil_N10_*.out"\
#	-var restartname3gb "Ta3_550_GB.restart"\
#	-var restartname4gb "Ta4_550_GB.restart"\
#	-var restartname5gb "Ta5_550_GB.restart"\
#	-var restartname3eq "Ta3_550_Eq_N10.restart"\
#	-var restartname4eq "Ta4_550_Eq_N10.restart"\
#	-var restartname5eq "Ta5_550_Eq_N10.restart"\
#	-var Ta 4\
#	-var a 0.5\
#	-var b 0.5\
#	-var c 0\
#	-var notchshape 10\			
#	-var cutoff 0.677\
#	-sf gpu  -pk gpu 4

##-----Shear Ta GB - Notch 10-----##
time mpirun /fslhome/dadams26/executables/lmp_gpu_NVsv\
	-log /fslhome/dadams26/log_output/Ta4_550_Shear_DA_N10.log\
	-in /fslhome/dadams26/lammps_scripts/Ta_Shear_DA.in\
	-var dumpname3sh "zdump.Ta3_550_Shear_N10_*.out"\
	-var dumpname4sh "zzzFinedump.Ta4_550_Shear_N10_*.out"\
	-var dumpname4sbox1 "zzFinedump.Ta4_550_N10_StressVolumePress1L_*.out"\
	-var dumpname4sbox2 "zzFinedump.Ta4_550_N10_StressVolumePress2R_*.out"\
	-var dumpname4sbox3 "zzFinedump.Ta4_550_N10_StressVolumePress3M_*.out"\
	-var dumpname5sh "zdump.Ta5_550_Shear_N10_*.out"\
	-var dumpname3bsh "zdump.Ta3_550_Shear_unfiltered_N10_*.out"\
	-var dumpname4bsh "zdump.Ta4_550_Shear_unfiltered_N10_*.out"\
	-var dumpname5bsh "zdump.Ta5_550_Shear_unfiltered_N10_*.out"\
	-var restartname3eq "Ta3_550_Eq_N10.restart"\
	-var restartname4eq "Ta4_550_Eq_N10.restart"\
	-var restartname5eq "Ta5_550_Eq_N10.restart"\
	-var restartname3sh "Ta3_550_Sh_N10.restart"\
	-var restartname4sh "Ta4_550_Sh_N10.restart"\
	-var restartname5sh "Ta5_550_Sh_N10.restart"\
	-var Ta 4\
	-var a 0.5\
	-var b 0.5\
	-var c 0\
	-var cutoff 0.677\
	-sf gpu  -pk gpu 4

##-----Equilibrate Ta GB - Notch 12-----##
#time mpirun /fslhome/dadams26/executables/lmp_gpu_NVsv\
#	-log /fslhome/dadams26/log_output/Ta4_550_Equil_DA_N12.log\
#	-in /fslhome/dadams26/lammps_scripts/Ta_Equil_DA.in\
#	-var dumpname3eq "zdump.Ta3_550_Equil_N12_*.out"\
#	-var dumpname4eq "zdump.Ta4_550_Equil_N12_*.out"\
#	-var dumpname5eq "zdump.Ta5_550_Equil_N12_*.out"\
#	-var restartname3gb "Ta3_550_GB.restart"\
#	-var restartname4gb "Ta4_550_GB.restart"\
#	-var restartname5gb "Ta5_550_GB.restart"\
#	-var restartname3eq "Ta3_550_Eq_N12.restart"\
#	-var restartname4eq "Ta4_550_Eq_N12.restart"\
#	-var restartname5eq "Ta5_550_Eq_N12.restart"\
#	-var Ta 4\
#	-var a 0.5\
#	-var b 0.5\
#	-var c 0\
#	-var notchshape 12\			
#	-var cutoff 0.677\
#	-sf gpu  -pk gpu 4

##-----Shear Ta GB - Notch 12-----##
time mpirun /fslhome/dadams26/executables/lmp_gpu_NVsv\
	-log /fslhome/dadams26/log_output/Ta4_550_Shear_DA_N12.log\
	-in /fslhome/dadams26/lammps_scripts/Ta_Shear_DA.in\
	-var dumpname3sh "zdump.Ta3_550_Shear_N12_*.out"\
	-var dumpname4sh "zzzFinedump.Ta4_550_Shear_N12_*.out"\
	-var dumpname4sbox1 "zzFinedump.Ta4_550_N12_StressVolumePress1L_*.out"\
	-var dumpname4sbox2 "zzFinedump.Ta4_550_N12_StressVolumePress2R_*.out"\
	-var dumpname4sbox3 "zzFinedump.Ta4_550_N12_StressVolumePress3M_*.out"\
	-var dumpname5sh "zdump.Ta5_550_Shear_N12_*.out"\
	-var dumpname3bsh "zdump.Ta3_550_Shear_unfiltered_N12_*.out"\
	-var dumpname4bsh "zdump.Ta4_550_Shear_unfiltered_N12_*.out"\
	-var dumpname5bsh "zdump.Ta5_550_Shear_unfiltered_N12_*.out"\
	-var restartname3eq "Ta3_550_Eq_N12.restart"\
	-var restartname4eq "Ta4_550_Eq_N12.restart"\
	-var restartname5eq "Ta5_550_Eq_N12.restart"\
	-var restartname3sh "Ta3_550_Sh_N12.restart"\
	-var restartname4sh "Ta4_550_Sh_N12.restart"\
	-var restartname5sh "Ta5_550_Sh_N12.restart"\
	-var Ta 4\
	-var a 0.5\
	-var b 0.5\
	-var c 0\
	-var cutoff 0.677\
	-sf gpu  -pk gpu 4

echo "End 5 5 0 origin- Tantalum 4"
