# Delta test results

(see https://molmod.ugent.be/deltacodesdft for further details)

**Pseudopotentials**: Goedecker-Teter-Hutter (GTH)

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
|     |    |      |                      |          |          | **Mean** | **0.018** |
