#!/bin/bash

##############################################################################
##
##  project start up for automated git project
##
##############################################################################

project_name=$1
new_file_stylized_index=""

if ls ~/Local\ Documents/working_directory/working_directory_* 1> /dev/null 2>&1; then
	# read last file name
	last_file_name=$(ls -r ~/Local\ Documents/working_directory/ |grep working_directory_ | head -1)

	# fetch the last index
	IFS='_'
	read -a strarr <<< "$last_file_name"
	last_file_index=${strarr[2]}
	last_file_index_number=$(echo $last_file_index | sed 's/^0*//')
	new_file_index=$(($last_file_index_number + 1))
	new_file_stylized_index=$(printf "%04d\n" $new_file_index)

	
else
	new_file_stylized_index=$(printf "%04d\n" 1)
fi

# create working directory
cd ~/Local\ Documents/working_directory/
mkdir "working_directory_$new_file_stylized_index"
echo "working directory working_directory_$new_file_stylized_index created."

# run pull request
cd ~/Local\ Documents/github/$project_name
echo "running pull request..."
git pull 

# copy code to working directory
echo "coping project to working directory..."
cp -r ../$project_name ~/Local\ Documents/working_directory/working_directory_$new_file_stylized_index

# copy additional files to working directory
if ls ~/Local\ Documents/credentials/$project_name 1> /dev/null 2>&1; then
	echo "coping credential files to working directory..."
	cp -r ~/Local\ Documents/credentials/$project_name ~/Local\ Documents/working_directory/working_directory_$new_file_stylized_index
fi

echo "project ready."

# open project in vs code
code ~/Local\ Documents/working_directory/working_directory_$new_file_stylized_index/$project_name

