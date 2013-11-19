# reddit-bg
##### Dino Fizzotti, 2013

### Description

Script for downloading images from subreddit links, and setting them as the desktop background. Created and tested for use with Mint 15 using Cinnamon 64-bit.

The script assumes user is using Cinnamon 1.8.8 which still uses a GNOME back-end. The will change in Cinnamon 2.0.

### Background

Primarily started as an excercise to re-familiarise myself with	linux, bash, git and related technologies.

### Prerequisites
* #### curl

	apt-get install curl

* #### jansson

	http://www.digip.org/jansson/
	Follow README instructions for installation.

* #### jshon

	http://kmkeen.com/jshon/
	1. untar the compressed archive downloaded fromt the source above
	2. make
	3. ldconfig
	4. mv jshon /usr/bin/ 
	(last line recommended, otherwise you have to run the script from the directory where the jshon binary exists)
		
### Overview
The script performs the following when run:

1. Gets the top 25 (default behaviour) links from the given subreddit.
2. Checks the top submission link URL to see if it has already been downloaded.
  * If it already exists in the download directory, pick the next one. Repeat until new link found.

3. Downloads the image from the new link URL to the download directory.
4. Sets the image as the desktop background wallpaper.
	
### Usage
Make the script executable:
```bash
chmod a+x reddit-bg.sh
```

Run the script with a subreddit and save folder as an argument:
```bash
./reddit-bg cityporn ~/Pictures/SavedImages/
```
