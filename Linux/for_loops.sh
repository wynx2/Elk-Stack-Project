#!/bin/bash

states=( 'Alaska' 'Hawaii' 'Wyoming' 'Texas' 'Arizona' )
hawaii_found=0
for state in ${states[@]}
    do
	if [ $state == 'Hawaii' ]
	    then
	        echo 'Hawaii is the best'
		hawaii_found=1
	fi
    done

if [ hawaii_found == 0 ]
    then
	echo "I'm not fond of Hawaii"
fi


