# Delta test results

(see https://molmod.ugent.be/deltacodesdft for further details)

**Pseudopotentials**: [Goedecker-Teter-Hutter (GTH)](https://github.com/cp2k/cp2k-data/tree/d0641939ca0a9bdf3ec10d29d011cacd434498ce/potentials/GTH_rev/ABINIT/PBE)

**Code**: [ABINIT 9.4.2](https://www.abinit.org)

**Exchange-correlation functional**: PBE (ixc = 11)

**Cutoff energy**: ecut &ge; 200 Hartree (see table)

**Fermi-Dirac smearing**: tsmear = 1 mHartree

**k-mesh density**: kptrlen &gt; 100 (see table)

| Z | Element | Z<sub>eff</sub> |  E<sub>cut</sub> [Hartree] | k point mesh | V<sub>0</sub> [&Aring;<sup>3</sup>/atom] | B<sub>0</sub> [GPa] | B<sub>1</sub> [-] | Delta [meV/atom] |
|  :---: | :---: | :---: | ---: | :---: | ---: | ---: | ---: | ---: |
|   1 | H  | q1   |   200.0 | 15&times;15&times;11 |   17.392 |   10.285 |    2.682 |     0.008 |
|   2 | He | q2   |   200.0 | 19&times;19&times;13 |   17.769 |    0.857 |    6.435 |     0.002 |
|   3 | Li | q3   |   200.0 | 19&times;19&times;19 |   20.233 |   13.840 |    3.323 |     0.042 |
|   4 | Be | q4   |   200.0 | 25&times;25&times;17 |    7.909 |  123.377 |    3.245 |     0.022 |
|   5 | B  | q3   |   200.0 | 11&times;11&times;11 |    7.239 |  233.928 |    3.434 |     0.158 |
|   5 | B  | q5   |   250.0 | 11&times;11&times;11 |    7.236 |  237.403 |    3.466 |    (0.233)|
|   6 | C  | q4   |   200.0 |  23&times;23&times;7 |   11.638 |  207.335 |    3.552 |     0.106 |
|   7 | N  | q5   |   200.0 |    9&times;9&times;9 |   28.884 |   52.766 |    3.650 |     0.217 |
|   8 | O  | q6   |   200.0 | 13&times;13&times;13 |   18.572 |   51.031 |    3.840 |     0.140 |
|   9 | F  | q7   |   250.0 |  11&times;17&times;9 |   19.169 |   34.149 |    4.025 |     0.026 |
|  10 | Ne | q8   |   250.0 | 13&times;13&times;13 |   24.220 |    1.201 |    7.217 |     0.044 |
|     |    |      |         |                      |          |          | **Mean** | **0.083** |
