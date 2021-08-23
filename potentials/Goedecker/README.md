The directory atom contains the source for the atomic all-electron program.
The directory pseudo contains the sources for two programs to fit the
parameters of Goedecker pseudopotentials.
#
# this is just a quick step-by-step reminder on how to get a GTH pseudo
# read cp2k-data/potentials/Goedecker/atom/README
# and  cp2k-data/potentials/Goedecker/pseudo/v2.2/README
# further relevant literature can be found in the folder paper
#
# always test a pseudopotential before using it!
#
# get code
git clone --recursive https://github.com/cp2k/cp2k-data.git

# build all needed executables
# makefiles might need modifications for your system

cd cp2k-data/potentials/Goedecker/atom/
gfortran -O2 -g hcth.f90 xc_b97.f90 atom.f -o atom.x

cd ~/potentials/Goedecker/pseudo/v2.2
make

# generate a new element
mkdir cp2k-data/potentials/Goedecker/build/hcth407/C
mkdir cp2k-data/potentials/Goedecker/build/hcth407/C/atom
mkdir cp2k-data/potentials/Goedecker/build/hcth407/C/psp_hcth407
cd cp2k-data/potentials/Goedecker/build/hcth407/C/atom
cp cp2k-data/potentials/Goedecker/build/blyp/C/atom/atom.dat .
vi atom.dat ! replace BLYP with HCTH407

# hoping for the best concerning convergence, GGA 
# typically don't reach the convergence of 1E-11, but e.g. 1E-7 or worse
# you may try to reduce aa in atom.dat to 5.0 or 4.0 for a better convergence
cp2k-data/potentials/Goedecker/atom/atom.x C

# pseudo
cd cp2k-data/potentials/Goedecker/build/hcth407/C/psp_hcth407
cp ../../../blyp/C/psp_blyp/psp.par .
cp ../../../blyp/C/psp_blyp/weights.par .
cp ../../../blyp/C/psp_blyp/FITPAR .
# Check that FITPAR has a t for channels you want to 
# fit (check ~/potentials/Goedecker/paper/2)
cp ../atom/atom.ae .
# replace BLYP with HCTH407
vi psp.par 

# -l1so zeros the l=1 angular momentum channel (for consistency with other e.g. PADE pseudos)
# improved initial guess can be obtained with
cp2k-data/potentials/Goedecker/pseudo/v2.2/pseudo.x -orth -c1000 -n400
# and iterate till convergence with
cp2k-data/potentials/Goedecker/pseudo/v2.2/pseudo.x -orth -c1000 -n400 -denbas -fullacc [-l1so]

# you may force the start of a new amoeba cycle with
touch NEXT
# before 400 iterations are completed. Values in the range 400 to 800 are appropriate for the
# -n option. The actual value for the -c option does not matter that much, since a pseudo.x run
# can always be stopped softly with
touch EXIT

# For the final check of the obtained fit just add the -plot option to the command used for
# the fit
cp2k-data/potentials/Goedecker/pseudo/v2.2/pseudo.x -orth -c1000 -n400 -denbas -fullacc [-l1so] -plot
# A set of data files is generated which allows a visual inspection of all fitted wavefunctions.
# Moreover, a command file pswf.gnu is created which can directly be loaded with
gnuplot pswf.gnu

# Optional: update database
cd cp2k-data/potentials/Goedecker/tools
./update_database.sh
