#!/bin/bash

USERS_FILE="usuarios.csv"
LOG_FILE="log.log"
echo $0
USERS_FILE_PATH="$0/$USERS_FILE"
LOG_FILE_PATH="./$LOG_FILE"
BACKUP_FOLDER="./backups"

declare -i keep_running=1

#Checks if file passed as param exists
check_file_exists(){
	if [ ! -e $1 ]
	then
		touch "./$1"
	fi
}

create_backup(){
	date=$(date +%d%m%Y_%H-%M-%S)
	backup_name="copia_usuarios_$date.zip"

	if [ ! -d $BACKUP_FOLDER ]
	then
		mkdir $BACKUP_FOLDER
	fi

	zip -r $BACKUP_FOLDER/$backup_name $USERS_FILE_PATH

	echo "[$(date +%d%m%Y_%H-%M-%S)] - Creating backup: $BACKUP_FOLDER/$backup_name" >> $LOG_FILE_PATH

	#Check last backups and delete last one if excedes 2

	counter=$(ls $BACKUP_FOLDER/*.zip | wc -l)

	if [ $counter -gt 2 ]
	then
		echo "[$(date +%d%m%Y_%H-%M-%S)] - Deleting backup: $(ls -lt $BACKUP_FOLDER/*.zip | tail -n 1)" >> $LOG_FILE_PATH
		rm  $BACKUP_FOLDER/$(ls -lt $BACKUP_FOLDER/*.zip | tail -n 1)
	fi

}

#Checking if resources exist
check_file_exists $USERS_FILE_PATH
check_file_exists $LOG_FILE_PATH


#Start loop for menu
while [ $keep_running -eq 1 ]
do
	echo -e "Bienvenido. \n\n"
	echo -e "1. EJECUTAR COPIA DE SEGURIDAD \n"
	echo -e "2. DAR DE ALTA USUARIO \n"
	echo -e "3. DAR DE BAJA AL USUARIO \n"
	echo -e "4. MOSTRAR USUARIOS \n"
	echo -e "5. MOSTRAR LOG DEL SISTEMA \n"
	echo -e "6. SALIR \n"
	read -p "¿Qué desea hacer? (1-6): " seleccion

case $seleccion in
        1)
            create_backup
            ;;
        2)
            dar_alta_usuario
            ;;
        3)
            dar_baja_usuario
            ;;
        4)
            mostrar_usuarios
            ;;
        5)
            mostrar_log
            ;;
        6)
            echo "Saliendo..."
		keep_running=0
            exit 0
            ;;
        *)
            echo "Opción no válida. Por favor, elige una opción entre 1 y 6."
            ;;
    esac
done
