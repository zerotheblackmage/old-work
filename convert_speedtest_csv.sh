#!/bin/bash

#quick and dirty script to convert specific logs to csv

filename="$1"
out="$2"

echo "Date;Server;Download speed;Upload speed" > $out

while read -r file; do
	if [[ $file == Upload* ]]; then
		echo $file | tr -d 'Upload:'  >> $out
	else
		file2=`echo -n $file | sed -e ':a;N;$!ba;s/\n/ /g' `

		echo -n $file2 \; >> $out
	fi
done < "$filename"

