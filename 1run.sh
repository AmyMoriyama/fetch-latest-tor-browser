#!/bin/bash
###########################################
## Deps: wget, grep, sed, tar
##
## Be sure to check the license file.
##
## Script to fetch latest torbrowser
###########################################

# set some vars
# change BIT to 32 or 64 depending on your system
# change LAN to two digit language
BIT='64'
LAN='en'

echo "Doing vars..."
VAR=$(wget -4 -q -O - https://www.torproject.org/download/languages/ | grep -o '<a href=['"'"'"][^"'"'"']*['"'"'"]' | sed -e 's/^<a href=["'"'"']//' -e 's/["'"'"']$//' | grep "tor-browser-linux$BIT" | grep "$LAN" | head -n -1)

VAR2=$(echo "$VAR" | sed 's@.*/@@')

# download the thing
echo ""
echo "Downloading the thing..."
wget -4 -q --show-progress "https://www.torproject.org$VAR"

# remove any old versions
DIR=$(ls -d */ | grep 'tor-browser_' 2> /dev/null)
rm -r $DIR 2> /dev/null

# extract
echo ""
echo "Extracting the thing..."
tar -xf ./$VAR2

# cleanup
echo ""
echo "Cleaning up..."
rm ./$VAR2
rm old-version 2> /dev/null
mv current-version old-version 2> /dev/null
echo $VAR2 >> current-version

echo "Done, if no errors above"
