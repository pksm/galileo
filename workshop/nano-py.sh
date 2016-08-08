#!/bin/sh
# create a copy of current settings
FILE=/usr/share/nano/python.nanorc
cp $FILE $FILE.old
# search for '\<' and '\>' and substitutes for \b
while read line
do
	sed -i 's;\\<;\\b;g' $FILE
	sed -i 's/\\>/\\b/g' $FILE
done < $FILE
# include edited file in a .nanorc file on user's home directory 
# obs: .nanorc is read before the editor open
echo include "/usr/share/nano/python.nanorc" >> ~/.nanorc
# the above command just append a new line to .nanorc file (it may have duplicates)
