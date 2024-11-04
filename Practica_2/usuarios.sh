#!/bin/bash

ERROR_LOG="usuarios_error.log"


show_user() {
    user=$1

    if id "$user" &>/dev/null; then

        nombre=$(getent passwd "$user" | cut -d: -f1)
        uid=$(getent passwd "$user" | cut -d: -f3)
        gid=$(getent passwd "$user" | cut -d: -f4)
        directorio=$(getent passwd "$user" | cut -d: -f6)

        echo "Nombre de usuario: $nombre"
        echo "UID: $uid"
        echo "GID: $gid"
        echo "Directorio de trabajo: $directorio"
    else
        # Mensaje de error y log
        echo "El usuario '$user' no existe."
        echo "Error: El usuario '$user' no existe." >> "$ERROR_LOG"
    fi
}

while true; do
    echo "Introduce el nombre de usuario:"
    read -r usuario

    show_user "$usuario"

    echo "¿Quieres introducir otro usuario? (s/n)"
    read -r respuesta
    if [[ "$respuesta" != "s" && "$respuesta" != "S" ]]; then
        break
    fi
done

echo "Saliendo del programa."

