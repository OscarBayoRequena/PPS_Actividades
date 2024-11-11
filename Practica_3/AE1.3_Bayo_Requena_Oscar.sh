#!/bin/bash


# Variables globales
usuarios_file="usuarios.csv"
log_file="log.log"


# Función para verificar si el archivo de usuarios existe, si no, crear uno
verificar_usuarios_file() {
    if [ ! -f "$usuarios_file" ]; then
        touch "$usuarios_file"
        echo "El archivo $usuarios_file no existía y ha sido creado."
    fi
}


# Función para comprobar si un usuario existe
existe() {
    local user="$1"
    grep -q "$user" "$usuarios_file"
}


# Función para generar el nombre de usuario basado en el formato especificado
generaUser() {
    local nombre="$1"
    local apellido1="$2"
    local apellido2="$3"
    local dni="$4"


    # Extraer la primera letra del nombre y las tres primeras letras de los apellidos
    local nombre_usuario=$(echo "${nombre:0:1}${apellido1:0:3}${apellido2:0:3}" | tr '[:upper:]' '[:lower:]')
    
    # Extraer los tres últimos dígitos del DNI
    local dni_usuario=$(echo "$dni" | tail -c 4)


    echo "${nombre_usuario}${dni_usuario}"
}


# Función para realizar una copia de seguridad
backup() {
    # Generar el nombre del archivo de copia de seguridad
    local fecha=$(date +"%d%m%Y")
    local hora=$(date +"%H-%M-%S")
    local copia_file="copia_usuarios_${fecha}_${hora}.zip"


    # Crear una copia del archivo usuarios.csv
    zip "$copia_file" "$usuarios_file"


    # Registrar el log
    echo "COPIA DE SEGURIDAD realizada: $copia_file el $(date)" >> "$log_file"


    # Mantener solo las 2 copias de seguridad más recientes
    archivos=$(ls -t copia_usuarios_*.zip)
    count=0
    for archivo in $archivos; do
        if [ $count -ge 2 ]; then
            rm "$archivo"
        fi
        ((count++))
    done
}


# Función para dar de alta un usuario
alta() {
    # Pedir los datos del usuario
    read -p "Nombre: " nombre
    read -p "Apellido1: " apellido1
    read -p "Apellido2: " apellido2
    read -p "DNI (8 dígitos + letra): " dni


    # Verificar si el nombre de usuario ya existe
    nombre_usuario=$(generaUser "$nombre" "$apellido1" "$apellido2" "$dni")


    if existe "$nombre_usuario"; then
        echo "El usuario $nombre_usuario ya existe."
    else
        # Añadir el usuario al archivo
        echo "$nombre:$apellido1:$apellido2:$dni:$nombre_usuario" >> "$usuarios_file"
        echo "Usuario $nombre_usuario añadido."


        # Registrar el log
        echo "INSERTADO $nombre:$apellido1:$apellido2:$dni:$nombre_usuario el $(date)" >> "$log_file"
    fi
}


# Función para dar de baja un usuario
baja() {
    # Pedir el nombre de usuario a eliminar
    read -p "Nombre de usuario a eliminar: " usuario


    # Verificar si el usuario existe
    if existe "$usuario"; then
        # Eliminar el usuario
        grep -v "$usuario" "$usuarios_file" > temp.csv && mv temp.csv "$usuarios_file"
        echo "Usuario $usuario eliminado."


        # Registrar el log
        echo "BORRADO $usuario el $(date)" >> "$log_file"
    else
        echo "El usuario $usuario no existe."
    fi
}


# Función para mostrar los usuarios
mostrar_usuarios() {
    # Verificar si hay usuarios
    if [ -s "$usuarios_file" ]; then
        # Mostrar los usuarios ordenados por nombre de usuario
        sort -t ':' -k5 "$usuarios_file" | awk -F ':' '{print $5}' 
    else
        echo "No hay usuarios registrados."
    fi
}


# Función para mostrar el log
mostrar_log() {
    if [ -s "$log_file" ]; then
        cat "$log_file"
    else
        echo "No hay registros en el log."
    fi
}


# Función para realizar el login
login() {
    local intentos=0
    local usuario


    # Verificar si se ejecuta como admin
    if [ "$1" == "-root" ]; then
        return 0  # Siempre permite el acceso como admin
    fi


    while [ $intentos -lt 3 ]; do
        read -sp "Introduce tu nombre de usuario: " usuario
        echo


        # Verificar si el usuario existe
        if existe "$usuario"; then
            return 0
        else
            echo "Usuario no válido. Intento $((intentos + 1)) de 3."
            ((intentos++))
        fi
    done


    echo "Demasiados intentos fallidos. Saliendo."
    exit 1
}


# Función principal que controla el flujo del script
inic() {

    # Verificar si el archivo de usuarios existe
    verificar_usuarios_file


    # Hacer login
    login "$1"


    # Mostrar el menú
    while true; do

	echo "1.- EJECUTAR COPIA DE SEGURIDAD"
    	echo "2.- DAR DE ALTA USUARIO"
    	echo "3.- DAR DE BAJA AL USUARIO"
    	echo "4.- MOSTRAR USUARIOS"
    	echo "5.- MOSTRAR LOG DEL SISTEMA"
    	echo "6.- SALIR"

        read -p "Selecciona una opción: " opcion


        case $opcion in
            1) backup ;;
            2) alta ;;
            3) baja ;;
            4) mostrar_usuarios ;;
            5) mostrar_log ;;
            6) echo "Saliendo..."; exit 0 ;;
            *) echo "Opción no válida. Inténtalo de nuevo." ;;
        esac
    done
}


# Ejecutar la función principal
inic "$1”
