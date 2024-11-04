#!/bin/bash

mes=$(date +%m)
nombre_mes=$(date +%B)

dias=0

case $mes in
    01|03|05|07|08|10|12)
        dias=31
        ;;
    04|06|09|11)
        dias=30
        ;;
    02)
        dias=28
        ;;
    *)
        echo "Mes no válido"
        exit 1
        ;;
esac

echo "Estamos en $nombre_mes, un mes con $dias días."

