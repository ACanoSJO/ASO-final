#!/bin/bash
function MarkTask(){
    continue="Y"
    while [ "$continue" == "Y" ]
    do
        # Muestro todas las tareas
        clear
        cat $userTasksDB
        echo
        read -p "Inserta la ID de la tarea que quieras marcar: " opId
        line=0
        # Se mira en que linea esta la id
        totalLines=`wc -l < $userDB`
        # esta variable se marcara como true si el usuario existe
        checkExists="false"
        while [ "$id" != "$opId" ]
        do
            let "line=$line+1"
            id=$(sed -n "${line}s/^\([0-9]\{3\}\).*$/\1/p" "$userTasksDB")
            if [ "$line" == "$totalLines" -a "$id" != "$opId" ]
            then
                echo "La tarea no existe"
                # "sleep pausa el script durante 5 segundos"
                stty -echo
                read -p "Pulsa enter para continuar..."
                stty echo
                checkExists="true"
                break
            fi
        done
        # Si la tarea existe nos saltamos el resto del bucle con un "continue" y volvemos a emprezar
        if [ "$checkExists" == "true" ]
        then
            continue
        fi
        # Se sustituye el caracter de $2 por el caracter de $1
        sed -i "${line}s/$2/$1/" "$userTasksDB"
        # Pregunta para reinciar la funcion
        
        read -p "Quieres seguir marcando?[Y/N] " continue
        
        while [[ ! "$continue" == "Y" && ! "$continue" == "N" ]]
        do
            clear
            echo "Opcion no valida, vuelve a intentarlo"
            read -p "Quieres seguir marcando?[Y/N] " continue
        done
    done
}
function checkTasks(){
    opMarcar=0
    while [ ! $opMarcar -eq 3 ]
    do
        clear
        echo Quieres marcar/desmarcar algunas tareas?
        echo "1)Marcar"
        echo "2)Desmarcar"
        echo "3)Salir"
        read -p "OPCION: " opMarcar
        case $opMarcar in
            1)
                # marcara el campo
                MarkTask x -
            ;;
            2)
                # desmarcara el campo
                MarkTask - x
            ;;
        esac
    done
}