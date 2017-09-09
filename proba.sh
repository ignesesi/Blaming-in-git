#!/bin/bash

COMMAND=$1
WORD=$2
PAR=$3
NAME="./proba.sh"
INVALID="For help write $NAME -h'"

if [ "$PAR" = "" ]
then
	echo T U $PAR K
	if [ "$COMMAND" = "-h" ]
	then
		echo HOW TO USE
		echo -s "<WORD>" Search for WORD in each file.
		echo -h Output a ussage message. 
	elif [ "$COMMAND" = "-s" ]
	then
		if [ "$WORD" = "" ]
		then
			echo Need more arguments...
			echo $INVALID
		else
			echo Start searching...
			echo

			grep -Hrnw "$WORD" ./* --exclude-from .gitignore | while [ read res ]
			do
				path=`echo "$res" | cut -d: -f1`
				line=`echo "$res" | cut -d: -f2`
				email=`git blame -e -p -L $line,$line $path | head -n 3 | tail -n 1 | cut -d '<' -f2 | cut -d '>' -f1`

				echo ${email}:${res};
			done

			echo
			echo DONE

		fi
	else
		echo Unknown arguments...
		echo $INVALID
	fi
else
	echo Too many arguments...
	echo $INVALID
fi

echo
