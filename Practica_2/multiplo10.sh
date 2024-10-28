#!/bin/bash

if [ $# -ne 1 ]
then
	echo "Número de parameros incorrecto"
	exit 1
else
	if [[ $1 =~ ^-?[0-9]+$ ]] #Check if param is number
	then
		if (($1%10 == 0 ))
		then
			echo "El número introducido es múltiplo de 10"
			exit 0
		else
			echo "El número introducido no es múltiplo de 10"
			exit 0
		fi
	else
		echo "El parámetro introducido no es un número"
		exit 1
	fi
fi
