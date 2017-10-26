#!/bin/bash

# Quick and dirty script to get the info needed to convert a plate
# Version 0.0.0.0.0.0.0.0.0.0.3


# requires OpenEXR

depen=`which exrheader`

if [ -z "$depen" ]; then
        echo "You need to have the OpenEXR package installed to use this script"
        echo "it can be added with the following command"
        echo "apt-get install openexr"
        exit 1
fi 
echo " "
echo "please note: this script provides an estimate of the resolution"
echo "It will still group similarly sized shots together, but make sure"
echo "to open at least one file in bview to confirm the resolution"
echo " "




# Get the path to use

echo "Please enter the path where the plate can be found (no leading / please)"

read pth

# Find out how many shots there are

num=`ls -l $pth | wc -l`
numb=$((num-1))

echo " "
echo "There are $numb shots"
echo " "
echo "If there is a discrepancy between the above and the number of shots given,"
echo "the other images might not have headers,"
echo "meaning that you'll need to open the missing files manually in bview"
echo " "
# get the resolution of the first image in each

pth2=`ls $pth`

#arrays for later
name=()
resol=()
comment=()
x=0



for i in $pth2 ; do
	pth3=$pth/$i 


#	Get the relevant files
	fn=`bls $pth3 | grep "\["`


#	Get the extension (just in case it's not a .dpx)
	ext=`echo $fn | tail -c 4`



#	get the first file in the directory using the extension ( just in case it's not *.1001.dpx )
	fir=`ls $pth3 | grep $ext | head -1`

#	Get the resolution of the first file
	res2=(`exrheader $pth3/$fir | grep SourceResolution | cut -c 33- | sed 's/\"//g'`)

#	echo $res

#	res2=`echo ${res} | rev | cut -c 5- | rev `
	

#	output the  folder and resolution
	cap=`echo $i | tr '[:lower:]' '[:upper:]'`
	cap2=`echo '#'$cap`

	resol[$x]=$res2
	name[$x]=$pth3/$fn
	comment[$x]=$cap2

	x=$((x+1))

done

#re-init x
x=0

# get the unique resolutions

newres=($(echo "${resol[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' '))


# Bring it all together


for i in ${newres[@]}; do
	echo $i

	x=0
	for j in ${resol[@]}; do
			if [ "$j" == "$i" ]; then
			       echo "${name[$x]}${comment[$x]}"
			fi
		x=$((x+1))
	done
	echo " "
done

for i in ${newres[@]}; do
        echo $i

        x=0
        for j in ${resol[@]}; do
                        if [ "$j" == "$i" ]; then
                        thing=`echo "${comment[$x]}" | sed 's/#//g'`

			echo -n "$thing "
                        fi
                x=$((x+1))
        done
        echo " "
done



exit 0
