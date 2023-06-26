#!/bin/sh
# Collects the pseudopotential files XX (CPMD format),
# CP2K, and ABINIT in the Goedecker/build tree
#
typeset -i line1=0 line2=0
cp2klibpath=../cp2k
cp2ksoclibpath=../cp2k_soc
cpmdlibpath=../cpmd
abinitlibpath=../abinit
texlibpath=../tex
cd ../build
echo Collecting new XX, CP2K, CP2K_SOC, and ABINIT files ...
for xcfun in blyp bp hcth120 hcth407 pade pbe pbesol olyp; do
   for d in ${cp2klibpath} ${cp2ksoclibpath} ${cpmdlibpath} ${abinitlibpath} ${texlibpath}; do
      [[ ! -d $(pwd)/${d}/${xcfun} ]] && mkdir -p $(pwd)/${d}/${xcfun}
   done
   for xxfile in $(find ${xcfun} -name XX); do
      el=$(echo ${xxfile} | cut -d"/" -f2)
      q=$(head -3 ${xxfile} | tail -n 1 | cut -d"=" -f2 | cut -d"." -f1)
      q=$(echo ${q})
      ppdir=$(dirname ${xxfile})
      cp2kfile=${ppdir}/CP2K
      cp2ksocfile=${ppdir}/CP2K_SOC
      cpmdfile=${ppdir}/CPMD
      abinitfile=${ppdir}/ABINIT
      texfile=${ppdir}/TEXTAB
      pppdir=$(basename $(dirname ${ppdir}))
      if [[ ${pppdir} == *_* ]]; then
         ext="_$(echo ${pppdir} | cut -d_ -f2)"
         sed -e "1s/$/${ext}/" -i ${cp2kfile}
         sed -e "1s/$/${ext}/" -i ${cp2ksocfile}
      else
         ext=
      fi
      cpmdlibfile=${cpmdlibpath}/${xcfun}/${el}-q${q}${ext}
      cp2klibfile=${cp2klibpath}/${xcfun}/${el}-q${q}${ext}
      cp2ksoclibfile=${cp2ksoclibpath}/${xcfun}/${el}-q${q}${ext}
      abinitlibfile=${abinitlibpath}/${xcfun}/${el}-q${q}${ext}
      texlibfile=${texlibpath}/${xcfun}/${el}-q${q}${ext}
      line1=$(grep -n "&POTENTIAL" $xxfile | cut -f1 -d":")
      line2=$(wc -l $xxfile | cut -f1 -d" ")
      head -7 $xxfile >$cpmdfile
      cat $(dirname $xxfile)/INFO >>$cpmdfile
      tail -n $((line2 - line1 + 2)) $xxfile >>$cpmdfile
      if [[ -f $cpmdlibfile ]]; then
         if [[ -n $(diff $cpmdfile $cpmdlibfile) ]]; then
            mv $cpmdfile $cpmdlibfile
            echo "Changed file $cpmdfile was moved to $cpmdlibfile"
         fi
      else
         mv $cpmdfile $cpmdlibfile
         echo "New file $cpmdfile was moved to $cpmdlibfile"
      fi
      if [[ -f $cp2klibfile ]]; then
         if [[ -n $(diff $cp2kfile $cp2klibfile) ]]; then
            mv $cp2kfile $cp2klibfile
            echo "Changed file $cp2kfile was moved to $cp2klibfile"
         fi
      else
         mv $cp2kfile $cp2klibfile
         echo "New file $cp2kfile was moved to $cp2klibfile"
      fi
      if [[ -f $cp2ksoclibfile ]]; then
         if [[ -n $(diff $cp2ksocfile $cp2ksoclibfile) ]]; then
            mv $cp2ksocfile $cp2ksoclibfile
            echo "Changed file $cp2ksocfile was moved to $cp2ksoclibfile"
         fi
      else
         mv $cp2ksocfile $cp2ksoclibfile
         echo "New file $cp2ksocfile was moved to $cp2ksoclibfile"
      fi
      if [[ -f $abinitlibfile ]]; then
         if [[ -n $(diff $abinitfile $abinitlibfile) ]]; then
            mv $abinitfile $abinitlibfile
            echo "Changed file $abinitfile was moved to $abinitlibfile"
         fi
      else
         mv $abinitfile $abinitlibfile
         echo "New file $abinitfile was moved to $abinitlibfile"
      fi
      if [[ $1 == "tex" ]]; then
         if [[ -f $texlibfile ]]; then
            if [[ -n $(diff $texfile $texlibfile) ]]; then
               mv $texfile $texlibfile
               echo "Changed file $texfile was moved to $texlibfile"
            fi
         else
            mv $texfile $texlibfile
            echo "New file $texfile was moved to $texlibfile"
         fi
      fi
   done
done
