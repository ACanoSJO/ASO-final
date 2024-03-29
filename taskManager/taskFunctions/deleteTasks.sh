#!/bin/bash
function deleteTasks(){
    userTasksDB=$1
    continue="Y"
    while [ "$continue" == "Y" ]
    do
        totalLines=`wc -l < $userTasksDB`
        if [ "$totalLines" -lt 1 ]
        then
            echo "No hay mas tareas a eliminar"
            stty -echo
            read -p "Pulsa enter para salir..."
            stty echo
            break
        fi
        
        clear
        echo Quieres continuar?
        echo "1)Si"
        echo "2)No, volver atras"
        read -p "OPCION: " opExit
        if [ $opExit = "2" ]
        then
            break
        fi
        
        clear
        cat $userTasksDB
        echo
        read -p "Inserta la ID de la tarea que quieras eliminar: " opId
        line=0
        
        # esta variable se marcara como true si el usuario existe
        checkExists="false"
        echo "Estas seguro [Y/N]"
        read -p "Opcion: " SopId
        case $SopId in
            "Y") # Elimina la tarea
                while [ "$id" != "$opId" ]
                do
                    let "line=$line+1"
                    id=$(sed -n "${line}s/^\([0-9]\{3\}\).*$/\1/p" "$userTasksDB")
                    if [ "$line" == "$totalLines" -a "$id" != "$opId" -a "$totalLines" ]
                    then
                        clear
                        echo "La tarea no existe"
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
                # Elimina la linea
                sed -i "${line}d; ${line}N" "$userTasksDB"
            ;;
            "N")
                continue #Vuelve a preguntar
            ;;
            *)
                stty -echo
                read -p "Input inesperado, la operacion sera cancelada. Pulsa enter para continuar..."
                stty echo
                continue
            ;;
        esac
        
        read -p "Quieres seguir eliminando?[Y/N] " continue
        while [[ ! "$continue" == "Y" && ! "$continue" == "N" ]]
        do
            clear
            echo "Opcion no valida, vuelve a intentarlo"
            read -p "Quieres seguir eliminando?[Y/N] " continue
        done
    done
}