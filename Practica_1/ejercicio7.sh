#!/bin/bash

if [ -d $1 ]
then
	echo "El elemento pasado es un directorio."
else
	echo "El elemento pasado es un fichero."
fi

