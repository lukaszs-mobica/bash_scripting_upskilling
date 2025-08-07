#!/bin/bash

targetDir="$1"
logFile="$2"

if [ -z "$1" ]; then
    echo "No directory to monitor specified"
	exit 1
fi

if [ -z "$2" ]; then
    echo "No log file specified"
	exit 1
fi


#Get initial state

prevFilesList=("$targetDir"/*)
prevTimeStamp=$(date "+%s")
