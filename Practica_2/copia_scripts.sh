#!/bin/bash

if [ $# -ne 1 ]
then
	echo "Número de parameros incorrecto"
	exit 1
else
	if [ -d $1 ]
	then
		declare DATE=$(date +"%d%m%Y")
		
		tar -czvf "copia_scripts_$DATE.tar.gz" $1 *.sh

		exit 0
	else
		echo "El parámetro pasado no es un parámetro válido."
		exit 1
	fi
fi
