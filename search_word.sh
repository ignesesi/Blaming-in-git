#!/bin/bash

WORD=$1
NAME="./search_word.sh"
INVALID="For help write $NAME -h'"

while [ "$WORD" = "" ]
do
	echo -n 'Enter a word: '
	read WORD
done

echo
echo Start searching...
echo

grep -Hrnw "$WORD" ./* --exclude-from .gitignore | while read res
do
	path=`echo "$res" | cut -d: -f1`
	line=`echo "$res" | cut -d: -f2`
	email=`git blame -e -p -L $line,$line $path | head -n 3 | tail -n 1 | cut -d '<' -f2 | cut -d '>' -f1`

	echo ${email}:${res};
done

echo
echo DONE

echo

