#!/bin/bash
#
#File : ProgressBar
#Description : This script can be used as a progress bar when a specific process is running
#               Useful while running commands taking long time, which helps user to know his machine was not stucked by the command.
#Pre-requisites : youtube-dl, Uget pre-installed.
#Author : cosmolabs
#DateCreated : 01-June-2019


lstCmndPid=0
# Reading command from user
read -p "Enter the command : " userCommand
exec $( $userCommand ) &
# Getting last executed command's process id.
lstCmndPid=$!
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
        # Progress bar.
        echo -n "#### "
        sleep 1
    fi
done
echo