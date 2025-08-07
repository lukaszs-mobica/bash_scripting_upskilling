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

while true; do
    
	sleep 1
	
	deleted=()
	
	#Get current state
	currentFilesList=("$targetDir"/*)
	currentTimeStampHumanReadable=$(date "-Iseconds")
	
	#Check for deleted files
	for file in "${prevFilesList[@]}"; do
		if [[ ! " ${currentFilesList[*]} " =~ " ${file} " ]]; then
			deleted+=($file)
		fi
    done
	
	#Write logs - if anything changed
	if [[ ${#deleted[@]} -gt 0 ]]; then
		echo "$currentTimeStampHumanReadable,deleted,${deleted[@]}" >> $logFile
	fi
	
	#Save current state as previous state
	prevFilesList=(${currentFilesList[@]})
	
done

