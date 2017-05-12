#!/bin/bash


# small script to easily rip DVDs/Blu-rays
# saves them in a /tmp folder for now


rip_time=`date +"%H-%M"`

#rip_time="16-10"
dir="/net/can_raid401/TMP/RIP-Test/"



full_dir="$dir""$rip_time"

mov_dir="$full_dir""/mov"

#echo $full_dir


echo "Beggining rip ..."

if [ ! -d "$full_dir" ]; then
	mkdir $full_dir
fi



if [ ! -d "$mov_dir" ]; then
        mkdir $mov_dir
fi



makemkvcon --minlength=30 mkv disc:0 all $full_dir


#for file in range{1..15} ; do
#	touch $full_dir/$file.mkv
#done

mkvs=`ls $full_dir | grep mkv`

for i in $mkvs ; do

	echo $i

	mov_file=`echo "$mov_dir/$i" | rev | cut -c 5- | rev`


	ffmpeg -i $full_dir/$i -vb 100000k -vcodec mpeg4 $mov_file.mov



done




cp $mov_dir ~/Desktop

echo "Conversion done. the files can now be found on your desktop. Press ENTER to quit"

read end
