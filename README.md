# GB-Dislocation-Interaction-LAMMPS
Repository for the bicrystal simulations in LAMMPS used to study GB-Dislocation interaction in FCC and BCC metals
Files Include:
  1. Tantalum Bicrystals
    1a. Ta_GBmin_DA.in : This is the first of three files used to create the bicrystal. It sets up the simulation cell, splits it into two grains with user determined orientations and minimizes the structure, thus created a GB at the center.
    1b. Ta_Equil_DA.in : This file removes sections of the bicrystal to simulate notches in each grain that will cause shear across the middle of the bicrystal when pulled. There are currently 13 different notch variations the user can choose from. Once the notches are removed, the bicrystal is equilibrated
    1c. Ta_Shear_DA.in : This file takes the equilibrated bycrystal and grabs the left and right ends and pulls them in tension. This is done to nucleate dislocations at the notch tips and observe how they interact with the GB
    1d. gpu_lammps_Ta_all#.sh : This is the executable file for each of the different Ta samples. The # varies depending on the sample, but the file has the same format for each. In it, the user can determine the origin coordinates, the name of the input and output files, the notch type, and the sample of Ta being modeled.
  2. Test files :
    2a. There are shortened versions of all of the Tantalum Bicrystal files that run in significantly less time. The file names are: Ta_Test.sh, Ta_Test_GBmin.in, Ta_Test_Equil.in, and Ta_Test_Shear.in
