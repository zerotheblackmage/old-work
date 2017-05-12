
#!/bin/python


# small script to easily rip DVDs/Blu-rays
# saves them in a /tmp folder for now
import os, sys
import time
import subprocess
from subprocess import call



rip_time = time.strftime("%H-%M")
print rip_time

full_dir = '/tmp/' + rip_time
mov_dir = full_dir + '/mov'



print full_dir
print mov_dir


#rip_time="16-10"
#dir="/tmp/"
if not os.path.exists(full_dir):
    os.makedirs(full_dir)
    
if not os.path.exists(mov_dir):
    os.makedirs(mov_dir)    
 
def startit():
    print "Beggining rip ..."
    return

def ripit():
    mkmv = "makemkvcon --minlength=30 mkv disc:0 all " + full_dir
    proc =  subprocess.Popen(['/bin/bash'], stdin=subprocess.PIPE, stdout=subprocess.PIPE)

    proc.communicate(mkmv)

    return

def switchit():
    for file in full_dir:
        if file.endswith(".mkv"):
            file2 = file.split(".")
            com = "ffmpeg -i " + full_dir +"/" + file + " -vcodec mpeg4 " + mov_dir + "/" + file2[0] + ".mov"
        
            print com
    
    
    return



startit()
time.sleep(5)
ripit()
print "Done ripping ... Converting to .mov"
switchit()


#mkvs=`ls $full_dir | grep mkv`

#for i in $mkvs ; do

#	echo $i

#	mov_file=`echo "$mov_dir/$i" | rev | cut -c 5- | rev`


#	ffmpeg -i $full_dir/$i -vb 100000k -vcodec mpeg4 $mov_file.mov



#done




#cp $mov_dir ~/Desktop

#echo "Conversion done. the files can now be found on your desktop. Press ENTER to quit"

#read end