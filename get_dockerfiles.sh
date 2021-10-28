#!/bin/bash

for REPOLINE in `cat $1 | jq .repo.name`;
	do
		USERNAME=`echo $REPOLINE | sed s/\"//g | cut -d'/' -f1`
		REPO=`echo $REPOLINE | sed s/\"//g | cut -d'/' -f2`
		
		echo "Processing..." $USERNAME $REPO;

		FILENAME="downloads/${USERNAME}_${REPO}_Dockerfile"
		echo "Downloading to... " $FILENAME

		REMOTE_REPO=https://raw.githubusercontent.com/$USERNAME/$REPO/master/Dockerfile

		echo $REMOTE_REPO

		curl -s $REMOTE_REPO > $FILENAME

		if cat $FILENAME | grep 404; then
			echo "DELETE THIS FILE..."
			rm $FILENAME
		fi		

	done