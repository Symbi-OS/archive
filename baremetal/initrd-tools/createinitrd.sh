#!/bin/bash

dirName=${1%/}
cpioName=$dirName'.cpio'

echo  $dirName
echo $cpioName

echo Removing $dirName.cpio and $dirName.cpio.gz
rm -rf $dirName.cpio $dirName.cpio.gz

echo "packing the cpio"
cpio-pack -d $dirName -o $cpioName
#find $dirName -print -depth | cpio -ov > $cpioName
echo "done" $cpioName

echo "Compressing the cpio"
gzip -k -9 $cpioName
echo "compressed " $cpioName".gz"
