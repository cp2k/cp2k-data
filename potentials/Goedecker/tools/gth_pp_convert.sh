#!/bin/sh
# Convert the psp.par files in the whole potentials/Goedecker/build tree
exe=$(pwd)/gth_pp_convert.x
echo Scanning build/ tree ... this may take some time, please wait
for xx in $(find ../build -name XX); do
   cd $(dirname $xx) >/dev/null
   echo Processing: $(pwd)
   if [[ -f atom.dat ]]; then
      $exe XX atom.dat psp.par
   else
      $exe XX ../atom/atom.dat psp.par
   fi
   #   cat INFO
   cd - >/dev/null
done
