#!/bin/bash
#
#File : vidosPlaylist_Downloader
#Description : This script will take the playlist URL as input and use Uget utility to download all the videos in the playlist.
#Pre-requisites : youtube-dl, Uget pre-installed.
#Author : cosmolabs
#DateCreated : 01-June-2019

# Get the playlist URL from user
read -p "Enter the playlist URL : " playListURL
# Get the directory from user
read -p "Enter the directory to save the playlist : " downloadDirectory

# Starting the process
echo -e "\nRetriving the individauls URL's from the playlist........."
# Generating individual URL's from playlist URL's
youtube-dl -o "https://www.youtu.be/%(id)s" --get-filename $playListURL > /tmp/playlistURLs
# Progress bar
lstCmndPid=0
# Give the file as input to uget by specifying the directory.
uget-gtk --folder=/tmp/playListVideos --input-file=/tmp/playlistURLs --quiet &
# Getting last executed command's process id.
lstCmndPid=$!
echo -e "\nDownload started........."
echo
# Running a loop till the last executed command found in the processes.
while [ $lstCmndPid != 0 ]
do
    # Getting the first coloumn(process id) of last executed command.
    lstCmndPid=`ps -e | grep $lstCmndPid | awk '{ print $1 }'`
    # checking whether the last excuetd command is available in processes.
    if [ -z $lstCmndPid ]
    then
        lstCmndPid=0
    else
        echo -n "#### "
        sleep 1
    fi
done
echo
# End progress bar
# Copying from temp folder to the user provided directory
cp -r /tmp/playListVideos $downloadDirectory
# Clearing temp files and directories
rm /tmp/playlistURLs
rm -r /tmp/playListVideos/
echo "Download finished.............."