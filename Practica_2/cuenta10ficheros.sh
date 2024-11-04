#!/bin/bash

if [ $# -ne 1 ]
then
	echo "Número de parameros incorrecto"
	exit 1
else
	declare full_route=$1

	if [ -d "$full_route" ]
	then
		total_count=$(ls -1 $full_route | wc -l)
		if [ $total_count -ge 10 ]
		then
			echo "Hay 10 o más ficheros en la carpeta"
			exit 0
		else
			echo "Hay menos de diez ficheros en la carpeta"
			exit 0
		fi
	else
		echo "La ruta no existe"
		exit 1
	fi
fi
