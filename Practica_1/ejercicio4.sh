#!/bin/bash

if [ $# -eq 0 ]
then
	echo "¡No has introducido parámetros!"
else
	echo "Has introducido $# parámetro/s."
	echo "Este/os parámetro/s es/son: $@ ."
fi
