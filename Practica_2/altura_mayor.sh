#!/bin/bash

if [ $# -ne 3 ]
then
	echo "Número de parameros incorrecto"
	exit 1
else
	declare -i not_number=0

	for i in "$@" #Check if all param are numbers
	do
		if [[ ! $i =~ ^-?[0-9]+$ ]]
		then
			not_number=1
		fi
	done

	if [ $not_number -ne 1 ]
	then
		if (( $1 > $2 ))
		then
			if (( $1 > $3 ))
			then
				echo "La persona mas alta mide $(echo "scale=2; $1 / 100" | bc)m"
			else
				echo "La persona mas alta mide $(echo "scale=2; $3 / 100" | bc)m"
			fi
		else
			if (( $2 > $3 ))
			then
				echo "La persona mas alta mide $(echo "scale=2; $1 / 100" | bc)m"
			else
				echo "La persona mas alta mide $(echo "scale=2; $2 / 100" | bc)m"
			fi
		fi
		exit 0
	else
		echo "Algún parámetro introducido no es un número"
		exit 1
	fi
fi
