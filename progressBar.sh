#!/bin/bash

#File : ProgressBar
#Description : This script can be used as a progress bar when a specific process is running
#               Useful while running commands taking long time, which helps user to know his machine was not stucked by the command.
#Pre-requisites : .
#Author : cosmolabs
#DateCreated : 01-June-2019
#DateModified : 08-08-2021

# Variable declarations
# start time in seconds
startTime=`date +%s`
lstCmndPid=0
sequence=0

# Reading command from user
read -p "Enter the command : " userCommand
exec $( $userCommand ) &
# Getting last executed command's process id.
lstCmndPid=$!
# Running a loop till the last executed command found in the processes.
while [ $lstCmndPid != 0 ]
do
    sequence=`expr ${sequence} + 1`
    # Getting the first coloumn(process id) of last executed command.
    lstCmndPid=`ps -e | grep $lstCmndPid | awk '{ print $1 }'`

    # checking whether the last excuetd command is available in processes.
    if [ -z $lstCmndPid ]
    then
        lstCmndPid=0
    else
        if [ ${sequence} == 1 ]
        then
            echo -n "["
        else        
            # Progress bar.
            echo -n "###"
        fi
    fi
    sleep 0.5
done
echo -n "]"

# End time in seconds
endTime=`date +%s`

runTime = `expr ($startTime - $endTime)`

echo ""
echo "Command executed : ${userCommand}"
echo "Time taken for command execution : ${endTime} seconds"
