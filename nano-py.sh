#!/bin/sh
# create copy of current settings
cp /usr/share/nano/python.nanorc /usr/share/nano/python.nanorc.old
# search for this \< and substitutes for \b
sed -i 's/\\</\\b/g' /usr/share/nano/python.nanorc
# search for this \> and substitutes for \b
sed -i 's/\\>/\\b/g' /usr/share/nano/python.nanorc
# includes the edited file in a .nanorc file on user's home directory 
# .nanorc is read before the editor open 
echo include "/usr/share/nano/python.nanorc" > ~/.nanorc
