#!/bin/bash

echo "Introduce el primer número:"
read num1
echo "Introduce el segundo número:"
read num2


if [[ $num1 =~ ^[0-9]*$ ]] && [[ $num2 =~ ^[0-9]*$ ]]
then
	if [ $num1 -lt $num2 ]; then
		inicio=$num1
		fin=$num2
	else
		inicio=$num2
		fin=$num1
	fi

	suma=0

	for (( i=inicio; i<=fin; i++ )); do
	    suma=$((suma + i))
	done

	echo "La suma de los números del $inicio al $fin es: $suma"
	exit 0
else
	echo "Los datos introducidos no son válidos"
	exit 1
fi
