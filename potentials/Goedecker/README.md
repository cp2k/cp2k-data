# Goedecker-Teter-Hutter (GTH) pseudopotentials

The database files of the available GTH pseudopoentials can be found [here](https://github.com/cp2k/cp2k-data/blob/master/potentials/Goedecker/cp2k/GTH_POTENTIALS) or can be selected [here](https://htmlpreview.github.io/?https://github.com/cp2k/cp2k-data/blob/master/potentials/Goedecker/index.html). The corresponding GTH pseudopotentals including the parameters for spin-orbit coupling (SOC) are provided by [this database file](https://github.com/cp2k/cp2k-data/blob/master/potentials/Goedecker/cp2k_soc/GTH_SOC_POTENTIALS).

## Create a new GTH pseudopotential

The directory [atom](atom) contains the source code for the atomic all-electron program.
The directory [pseudo](pseudo) contains the source files for two programs to fit the
parameters of Goedecker-Teter-Hutter (GTH) pseudopotentials.

This is just a quick step-by-step reminder on how to get a GTH pseudopotential.

Read [cp2k-data/potentials/Goedecker/atom/README](atom/README) and [cp2k-data/potentials/Goedecker/pseudo/v2.2/README](pseudo/v2.2/README).

> **Note**
> **Always test a new GTH pseudopotential before using it for production!**

### Get the codes

```
git clone --recursive https://github.com/cp2k/cp2k-data.git
```

### Build all needed executables

The file `Makefile` might need modifications for your system.

- #### Code for the all-electron atomic references

```
cd cp2k-data/potentials/Goedecker/atom/
gfortran -O2 -g hcth.f90 xc_b97.f90 atom.f -o atom.x
```

- #### Code to fit GTH pseudopotentials

```
cd cp2k-data/potentials/Goedecker/pseudo/v2.2
make
```

### Generate a new GTH pseudopotential for an element

- #### Prepare folders and copy input files from an existing GTH pseudopotential

```
mkdir cp2k-data/potentials/Goedecker/build/hcth407/C
mkdir cp2k-data/potentials/Goedecker/build/hcth407/C/atom
mkdir cp2k-data/potentials/Goedecker/build/hcth407/C/psp_hcth407
cd cp2k-data/potentials/Goedecker/build/hcth407/C/atom
cp cp2k-data/potentials/Goedecker/build/blyp/C/atom/atom.dat .
```

- #### Replace `BLYP` with `HCTH407` in `atom.dat` and run the all-electron atomic code hoping for the best concerning convergence

```
cp2k-data/potentials/Goedecker/atom/atom.x C
```

Typically the tight convergence of 1.0E-11 is not reached, but e.g. 1.0E-8 only which is still acceptable.
You may try to reduce `aa` in `atom.dat` to 5.0 or 4.0 for a better convergence.

- #### Generate a new GTH pseudopotential

```
cd cp2k-data/potentials/Goedecker/build/hcth407/C/psp_hcth407
cp ../../../blyp/C/psp_blyp/psp.par .
cp ../../../blyp/C/psp_blyp/weights.par .
cp ../../../blyp/C/psp_blyp/FITPAR .
```

- #### Check that `FITPAR` has a `t` for channels you want to fit

```
cp ../atom/atom.ae .
```

- #### Replace `BLYP` with `HCTH407` in `psp.par`

`-l1so` zeros the `l=1` angular momentum channel (for consistency with other e.g. PADE pseudos)
improved initial guess can be obtained with

```
cp2k-data/potentials/Goedecker/pseudo/v2.2/pseudo.x -orth -c1000 -n400
```

and iterate till convergence with

```
cp2k-data/potentials/Goedecker/pseudo/v2.2/pseudo.x -orth -c1000 -n400 -denbas -fullacc [-l1so]
```

You may force the start of a new amoeba cycle with

```
touch NEXT
```

before 400 iterations are completed. Values in the range 400 to 800 are appropriate for the
`-n` option. The actual value for the `-c` option does not matter that much, since a `pseudo.x` run can always be stopped softly with

```
touch EXIT
```

### Check the fit

For the final check of the obtained fit just add the `-plot` option to the command used for the fit

```
cp2k-data/potentials/Goedecker/pseudo/v2.2/pseudo.x -orth -c1000 -n400 -denbas -fullacc [-l1so] -plot
```

A set of data files is generated which allows a visual inspection of all fitted wavefunctions.
Moreover, a command file pswf.gnu is created which can directly be loaded with

```
gnuplot pswf.gnu
```

### Optional: Update database

```
cd cp2k-data/potentials/Goedecker/tools
./update_database.sh
```
