#!/bin/sh
# create copy of current settings
FILE=/usr/share/nano/python.nanorc
cp $FILE $FILE.old
# search for this \< and \> and substitutes for \b
while read line
do
	sed -i 's;\\<;\\b;g' $FILE
	sed -i 's/\\>/\\b/g' $FILE
done < $FILE
# includes the edited file in a .nanorc file on user's home directory 
# obs: .nanorc is read before the editor open
echo include "/usr/share/nano/python.nanorc" >> ~/.nanorc
