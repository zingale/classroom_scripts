#!/bin/bash

if [[ $# -ne 1 ]]; then
    echo "classroom_pull.sh takes a basename as an argument"
fi

dirs=`find . -name "$1*" -type d`

for d in ${dirs}
do
    cd $d
    git pull
    cd ..
done

