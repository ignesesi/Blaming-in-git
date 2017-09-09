#!/bin/bash

COMMAND=$1
WORD=$2
par=$3
name="./proba.sh"
invalid="For help write $name -h'"

echo

if [ "$COMMAND" = "-h" ]
then
	echo HOW TO USE
	echo -s "<word>"
	echo -h
elif [ "$COMMAND" = "-s" ]
then
	if [ "$WORD" = "" ]
	then
		echo Need more arguments...
		echo $invalid
	elif [ "$par" = "" ]
	then
		echo Start searching...
		grep -Hrnw "$WORD" ./* | while read res
		do
			path=`echo "$res" | cut -d: -f1`
			line=`echo "$res" | cut -d: -f2`
			git blame -e -p -L $line,$line $path | head -n 3 | tail -n 1 | cut -d '<' -f2 | cut -d '>' -f1
		done

		#path=`grep -Hrw "$WORD" ./* | cut -d: -f1`
		#line=`grep -hrnw "$WORD" ./* | cut -d: -f1`
		
		#IFS=' ' read -r -a array <<< "$line"

		#echo TUK
		#echo "${array[0]}"
		#echo "${array[1]}"
		#echo ASD
		#for element in "${array[@]}"
		#do
			#echo "$element"
		#done

		#echo TAM


		#echo $path
		#echo $line

		#otg=`cut $line -d ' ' -f 1`

		echo DONE
	else
		echo Too many arguments...
		echo $invalid
	fi	
elif [ "$COMAND" = "" ]
then
	echo Need arguments...
	echo $invalid
else
	echo Unknown arguments...
	echo $invalid
fi

echo
