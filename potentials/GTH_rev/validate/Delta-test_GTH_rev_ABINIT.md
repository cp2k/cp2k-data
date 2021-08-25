# Delta test results

(see https://molmod.ugent.be/deltacodesdft for further details)

**Pseudopotentials**: [Goedecker-Teter-Hutter (GTH)](https://github.com/cp2k/cp2k-data/tree/11583fd2c05d051b7b87ded2a5487d821704d2af/potentials/GTH_rev/ABINIT/PBE)

**Code**: [ABINIT 9.4.2](https://www.abinit.org)

**Exchange-correlation functional**: PBE (ixc = 11)

**Cutoff energy**: ecut = 200 Hartree

**Fermi-Dirac smearing**: tsmear = 1 mHartree

**k-mesh density**: kptrlen > 100 (see table)

| Z | Element | Z<sub>eff</sub> | k point mesh | V<sub>0</sub> [&Aring;<sup>3</sup>/atom] | B<sub>0</sub> [GPa] | B<sub>1</sub> [-] | Delta [meV/atom] |
|  :---: | :---: | :---: | :---: | ---: | ---: | ---: | ---: |
|   1 | H  | q1   | 15&times;15&times;11 |   17.392 |   10.285 |    2.682 |     0.008 |
|   2 | He | q2   | 19&times;19&times;13 |   17.769 |    0.857 |    6.431 |     0.002 |
|   3 | Li | q3   | 19&times;19&times;19 |   20.233 |   13.840 |    3.323 |     0.042 |
|   4 | Be | q4   | 25&times;25&times;17 |    7.909 |  123.377 |    3.245 |     0.022 |
|   5 | B  | q3   | 11&times;11&times;11 |    7.239 |  233.922 |    3.434 |     0.158 |
|   5 | B  | q5   | 11&times;11&times;11 |    7.230 |  237.535 |    3.462 |    (0.543)|
|   6 | C  | q4   | 23&times;23&times;7  |   11.625 |  207.433 |    3.550 |     0.106 |
|   7 | N  | q5   | 9&times;9&times;9    |   28.884 |   52.766 |    3.650 |     0.217 |
|     |    |      |                      |          |          | **Mean** | **0.079** |
