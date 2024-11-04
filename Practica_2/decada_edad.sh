#!/bin/bash

if [ $# -ne 1 ]
then
	echo "Número de parameros incorrecto"
	exit 1
else
	if [ $1 -le 60 ] && [ $1 -ge 15 ]
	then
		declare -i CURRENT_YEAR=$(date +%Y)
		declare -i bYear=$CURRENT_YEAR-$1
		declare -i yOffset=$bYear%10
		echo "Si naciste en $bYear, naciste en la década de $(($bYear-$yOffset))"
		exit 0
	else
		echo "Rango de edades no soportado"
		exit 1
	fi
fi
