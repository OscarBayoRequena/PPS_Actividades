#!/bin/bash

if [ $# -eq 0 ]
then
	echo "¡No has introducido parámetros!"
	exit 1
else
	echo "Has introducido $# parámetro/s."
	echo "Este/os parámetro/s es/son: $@ ."
	exit 0
fi
