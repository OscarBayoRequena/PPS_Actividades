#!/bin/bash

if [ $# -ne 2 ]
then
	echo "¡El número de parámetros pasados es incorrecto!"
else
	mkdir $1
	cp $2 $1
fi
