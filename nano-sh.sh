#!/bin/sh
#
# Adding shell syntax highlight support to Nano editor
# 
FILE=/usr/share/nano/sh.nanorc
cp $FILE $FILE.old
while read line
do
	sed -i 's;\\<;\\b;g' $FILE
	sed -i 's/\\>/\\b/g' $FILE
done < $FILE
echo include "/usr/share/nano/sh.nanorc" >> ~/.nanorc
