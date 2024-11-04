#!/bin/bash

if [ $# -ne 1 ]
then
	echo "Número de parameros incorrecto"
	exit 1
else
	if [[ $1 =~ ^[0-9]{4}$ ]]
	then
		declare -i resto=$1%12

		case $resto in
 			0)
        			animal="la rata"
        			;;
    			1)
       				animal="el buey"
        			;;
    			2)
    				animal="el tigre"
			        ;;
    			3)
			        animal="el conejo"
        			;;
			4)
			        animal="el dragón"
        			;;
			5)
        			animal="la serpiente"
        			;;
    			6)
        			animal="el caballo"
        			;;
    			7)
        			animal="la cabra"
        			;;
    			8)
        			animal="el mono"
        			;;
    			9)
        			animal="el gallo"
        			;;
    			10)
        			animal="el perro"
        			;;
    			11)
        			animal="el cerdo"
        			;;
    			*)
	        		echo "Error: Resto no válido."
    	    			exit 1
	        		;;
		esac

		echo "Tu animale es $animal"

		exit 0
	else
		echo "Formato del parámetro no válido"
		exit 1
	fi
fi
