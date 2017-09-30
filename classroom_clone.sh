#!/bin/bash

# This file is for cloning assignments made in GitHub Classroom
#
# It requires three command line arguments
# 1 - the name of the github classroom
# 2 - the name of the assignment
# 3 - the name of the file with a list of student names. 
#
# The names in the file MUST be one username per line, with a blank
# line at end.
#
# original author: @umasshokie, Megan Olsen
# mz: added ssh option via getopts

USE_SSH=0

while getopts ":s" opt; do
    case $opt in
        s)
            USE_SSH=1
            ;;
        \?)
            echo "Invalid option: -$OPTARG"
            ;;
    esac
done
shift $((OPTIND-1))

# Check that 3 parameters are given
if [[ $# -ne 3 ]]; then
   echo "This script will clone individual assignments from GitHub Classroom."
   echo "If you want to use it with group assignments, you will need a list of"
   echo "each group name instead of student usernames."
   echo ""
   echo "Please provide 3 parameters in this order:"
   echo "1. name of GitHub Classroom"
   echo "2. name of assignment"
   echo "3. name of the file holding student usernames or group names"
   echo ""
   echo "You may find it useful to set up your shell to know your GitHub credentials."
else

    #set parameters to more obvious variable names
    if [[ $USE_SSH -eq 1 ]]; then
        classroom="git@github.com:${1}/"
    else
        classroom="https://github.com/"$1"/"
    fi
    assignment=$2
    file=$3

    # read line by line and clone the assignment
    while read line
    do
	name=${assignment}-${line}
	git clone ${classroom}${name}
    done < $file
fi
