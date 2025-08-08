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
	added=()
	
	#Get current state
	currentFilesList=("$targetDir"/*)
	currentTimeStampHumanReadable=$(date "-Iseconds")
	
	#Check for deleted files
	for file in "${prevFilesList[@]}"; do
		if [[ ! " ${currentFilesList[*]} " =~ " ${file} " ]]; then
			deleted+=($file)
		fi
    done
	
	#Check for added files
	for file in "${currentFilesList[@]}"; do
		if [[ ! " ${prevFilesList[*]} " =~ " ${file} " ]]; then
			added+=($file)
		fi
    done
	
	#Write logs - if anything changed
	if [[ ${#deleted[@]} -gt 0 ]]; then
		echo "$currentTimeStampHumanReadable,deleted,${deleted[@]}" >> $logFile
	fi
	
	if [[ ${#added[@]} -gt 0 ]]; then
		echo "$currentTimeStampHumanReadable,added,${added[@]}" >> $logFile
	fi
	
	#Save current state as previous state
	prevFilesList=(${currentFilesList[@]})
	
done

