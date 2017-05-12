#!/bin/bash

# script to move a user's cache/mail off the nfs server and onto the local disk.
# it's a quick and dirty solution, but it moves the files and symlinks them.
# affects icedove, firefox, chrome. Users should see no difference.




user=`whoami`
fl=${user:0:1}

moz="/net/homes/$fl/$user/.mozilla"
ice="/net/homes/$fl/$user/.icedove"
chr1="/net/homes/$fl/$user/.config/google-chrome"
chr2="/net/homes/$fl/$user/.config/chromium"
nv="/net/homes/$fl/$user/.nv"



cd ~


# create directories where the cache will now live

if [ ! -d "/work/.mozilla" ]; then
	mkdir -p /work/.mozilla
else
	echo "Firefox folder exists"
fi

if [ ! -d "/work/.icedove" ]; then
	mkdir -p /work/.icedove
else
        echo "Icedove folder exists"
fi

if [ ! -d "/work/.chrome" ]; then
        mkdir -p /work/.chrome
else
        echo "Chrome folder exists"
fi


if [ ! -d "/work/.chromium" ]; then
        mkdir -p /work/.chromium
else
        echo "Chromium folder exists"
fi


if [ ! -d "/work/.nv" ]; then
        mkdir -p /work/.nv
else
        echo "Nvidia Cache folder exists"
fi


chmod 777 /work/.mozilla
chmod 777 /work/.icedove
chmod 777 /work/.chrome
chmod 777 /work/.chromium


# check to see if files are already linked, and set the flag if they are not





if [ -L $moz ]; then
	echo "Firefox already linked. nothing to do"
	dmoz="skip"
else
	dmoz="go"
fi

if [ -h $ice ]; then
        echo "Icedove already linked. nothing to do"
	dice="skip"
else
	dice="go"
fi

if [ -h $chr1 ]; then
        echo "Chrome already linked. nothing to do"
	dchr1="skip"
else
	dchr1="go"
fi

if [ -h $chr2 ]; then
        echo "Chromium already linked. nothing to do"
	dchr2="skip"
else
	dchr2="go"
fi


if [ -h $nv ]; then
        echo "Nvidia already linked. nothing to do"
        dnv="skip"
else
        dnv="go"
fi




# kill the associated services

if [ "$dmoz" == "go" ]; then
	kf=`pidof firefox-esr`
	echo Killing Firefox
	kill -9 $kf
fi

if [ "$dice" == "go" ]; then
	kf=`pidof icedove`
        echo Killing Icedove
	kill -9 $kf
fi

if [ "$dchr1" == "go" ]; then
        kf=`pidof chrome`
        echo Killing Chrome
        kill -9 $kf
fi

if [ "$dchr2" == "go" ]; then
        kf=`pidof chromium`
        echo Killing Chromium
        kill -9 $kf
fi

# no real process for nvidia. this is a "sit and pray" moment



#move the contents and symlink

if [ "$dmoz" == "go" ]; then
	echo "copying Firefox"
        cp -r $moz/* /work/.mozilla
	echo "backing up firefox to $moz.bak"
        mv $moz $moz.bak
	echo "creating the symlink"
	ln -s /work/.mozilla $moz
	echo "Firefox done"
else
	echo "skipping Firefox"
fi

if [ "$dice" == "go" ]; then
	echo "copying icedove"
        cp -r $ice/* /work/.icedove
        echo "backing up ice to $ice.bak"
        mv $ice $ice.bak
        echo "creating the symlink"
        ln -s /work/.icedove $ice
        echo "Icedove done"
else
	echo "skipping Icedove"
fi

if [ "$dchr1" == "go" ]; then
        echo "copying Chrome"
        cp -r $chr1/* /work/.chrome
        echo "backing up chrome to $chr1.bak"
        mv $chr1 $chr1.bak
        echo "creating the symlink"
        ln -s /work/.chrome $chr1
        echo "Chrome done"
else
	echo "skipping Chrome"
fi

if [ "$dchr2" == "go" ]; then
        echo "copying Chromium"
        cp -r $chr2/* /work/.chromium
        echo "backing up chromium to $chr2.bak"
        mv $chr2 $chr2.bak
        echo "creating the symlink"
        ln -s /work/.chromium $chr2
        echo "Chromium done"
else
	echo "skipping Chromium"
fi


if [ "$dnv" == "go" ]; then
        echo "copying Nvidia"
        cp -r $nv/* /work/.nv
        echo "backing up Nvidia to $nv.bak"
        mv $nv $nv.bak
        echo "creating the symlink"
        ln -s /work/.nv $nv
        echo "Nvidia done"
else
        echo "skipping Nvidia"
fi


