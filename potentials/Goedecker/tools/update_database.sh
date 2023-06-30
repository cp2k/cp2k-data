#!/bin/sh
# Update the database for the Goedecker-Teter-Hutter
# pseudopotentials (GTH PP) in CPMD format, CP2K/Quickstep,
# and ABINIT format

# Generate the CP2K and ABINIT files by converting the
# psp.par files in the build/ tree
if [[ ! -f gth_pp_convert.x ]]; then
   gfortran -fno-sign-zero -o gth_pp_convert.x gth_pp_convert.f90
fi
./gth_pp_convert.sh

# Copy all XX files to the database in ../cpmd
# Copy all CP2K files to the database in ../cp2k
# Copy all ABINIT files to the database in ../abinit
./collect_files.sh $1

# Remove files in the build/ tree
echo Removing all the CP2K files in the build/ tree ...
find ../build -name CP2K -exec rm {} \;
echo Removing all the CP2K_SOC files in the build/ tree ...
find ../build -name CP2K_SOC -exec rm {} \;
echo Removing all the ABINIT files in the build/ tree ...
find ../build -name ABINIT -exec rm {} \;
echo Removing all the CPMD files in the build/ tree ...
find ../build -name CPMD -exec rm {} \;
echo Removing all the INFO files in the build/ tree ...
find ../build -name INFO -exec rm {} \;
echo Removing all the TEXTAB files in the build/ tree ...
find ../build -name TEXTAB -exec rm {} \;

# Create a new GTH_POTENTIALS database file for CP2K/Quickstep
./create_cp2k_potential_file.sh

# Create a new GTH_SOC_POTENTIALS database file for CP2K/Quickstep
./create_cp2k_soc_potential_file.sh

if [[ $1 == "tex" ]]; then
   ./create_tex_file.sh
else
   rm -rf ../tex
fi

# Clean up
rm -f gth_pp_convert.x

echo GTH PP database update finished
