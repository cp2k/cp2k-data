The directory atom contains the source for the atomic all-electron program.
The directory pseudo contains the sources for two programs to fit the
parameters of Goedecker-Teter-Hutter (GTH) pseudopotentials.

This is just a quick step-by-step reminder on how to get a GTH pseudopotential
read cp2k-data/potentials/Goedecker/atom/README d  cp2k-data/potentials/Goedecker/pseudo/v2.2/README
Always test a pseudopotential before using it!

1) Get the codes
```
git clone --recursive https://github.com/cp2k/cp2k-data.git
```

2) Build all needed executables (makefiles might need modifications for your system)
- Code for the all-electron atomic references
```
cd cp2k-data/potentials/Goedecker/atom/
gfortran -O2 -g hcth.f90 xc_b97.f90 atom.f -o atom.x
```
- Code to fit GTH pseudopotentials
```
cd cp2k-data/potentials/Goedecker/pseudo/v2.2
make
```

3) Generate a new GTH pseudopontelement
- Prepare folders and copy input files from existing GTH potential
```
mkdir cp2k-data/potentials/Goedecker/build/hcth407/C
mkdir cp2k-data/potentials/Goedecker/build/hcth407/C/atom
mkdir cp2k-data/potentials/Goedecker/build/hcth407/C/psp_hcth407
cd cp2k-data/potentials/Goedecker/build/hcth407/C/atom
cp cp2k-data/potentials/Goedecker/build/blyp/C/atom/atom.dat .
```
Replace BLYP with HCTH407 in `atom.dat`.
Hoping for the best concerning convergence, GGA 
Typically don't reach the convergence of 1.0E-11, but e.g. 1.0E-7 or worse
you may try to reduce aa in atom.dat to 5.0 or 4.0 for a better convergence
```
cp2k-data/potentials/Goedecker/atom/atom.x C
```
Generate GTH pseudopotential
```
cd cp2k-data/potentials/Goedecker/build/hcth407/C/psp_hcth407
cp ../../../blyp/C/psp_blyp/psp.par .
cp ../../../blyp/C/psp_blyp/weights.par .
cp ../../../blyp/C/psp_blyp/FITPAR .
````
Check that FITPAR has a t for channels you want to fit
```
cp ../atom/atom.ae .
```
Replace BLYP with HCTH407 in `psp.par`
`-l1so` zeros the `l=1` angular momentum channel (for consistency with other e.g. PADE pseudos)
improved initial guess can be obtained with
```
cp2k-data/potentials/Goedecker/pseudo/v2.2/pseudo.x -orth -c1000 -n400
```
and iterate till convergence with
```
cp2k-data/potentials/Goedecker/pseudo/v2.2/pseudo.x -orth -c1000 -n400 -denbas -fullacc [-l1so]
```
you may force the start of a new amoeba cycle with
```
touch NEXT
```
before 400 iterations are completed. Values in the range 400 to 800 are appropriate for the
-n option. The actual value for the -c option does not matter that much, since a pseudo.x run
can always be stopped softly with
```
touch EXIT
```
For the final check of the obtained fit just add the -plot option to the command used for
the fit
```
cp2k-data/potentials/Goedecker/pseudo/v2.2/pseudo.x -orth -c1000 -n400 -denbas -fullacc [-l1so] -plot
```
A set of data files is generated which allows a visual inspection of all fitted wavefunctions.
Moreover, a command file pswf.gnu is created which can directly be loaded with
```
gnuplot pswf.gnu
```
Optional: update database
```
cd cp2k-data/potentials/Goedecker/tools
./update_database.sh
```
