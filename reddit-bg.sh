#!/bin/bash

# Check the number of arguments passed to the script.
if [ $# -ne 2 ]; then
	echo "reddit-bg requires exactly two arguments"
	echo "E.g. $ ./reddit-bg.sh cityporn /home/<user>/Pictures/"
	exit 1
fi

# Check that the second argument is a valid directory.
if [ ! -d "$2" ]; then
	echo "$2 is not a valid directory."
	exit 1
fi

# Give the arguments nicer names
subreddit=$1
downloadDir=$2

# Gets a list of URLs which are direct links to images
imageList=$(curl -s http://www.reddit.com/r/$subreddit.json | jshon -e data -e children -a -e data -e url -u \
	| grep '.\(jpe\|jp\|pn\)g$')

if [[ ! -z $imageList ]] ; then # Checks to see if there are any results from the curl operation
	download=0
	for image in $imageList
	do
		if [ $download -eq 0 ] ; then
			filename=$(basename "$image") # Gets the filename from the URL
			filepath=$downloadDir/$filename
			if [ ! -e $filepath ]; then # Checks if the image does not already exist in the download folder
				echo "$filename does not exist in $downloadDir"
				echo "Attempting download..."								
				wget $image -P $downloadDir # Performs the download
				if [ -e $filepath ] ; then
					echo "Successfully downloaded new desktop background wallpaper!"
					echo "Applying wallpaper."
					# Sets the wallpaper
					gsettings set org.gnome.desktop.background picture-uri file://$filepath
					# Applies the wallpaper
					gsettings set org.gnome.desktop.background picture-options "scaled"
					download=1
					echo "Finished! Go check it out :)"
					break
				else
					echo "Download was unsuccessful :("
				fi
			else
					echo "$filename already exists in $downloadDir"
					echo "Let's try the next image..."
			fi
		fi	
	done
	if [ $download -eq 0 ] ; then
		echo "Links were found, but download attempts were all unsuccessful :(" 
	fi
else
	echo "No image links found for subreddit \"$subreddit\""
fi
