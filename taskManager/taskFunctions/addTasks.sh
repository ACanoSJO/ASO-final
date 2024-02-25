#!/bin/bash
# 001:dd/mm/yyyy:x/-:descripcion
function addTasks(){
    userTasksDB="$1"
    continue="Y"
    date=`date +%d/%m/%Y`
    
    while [ "$continue" = "Y" ]
    do
        lines=`wc -l < $userTasksDB`
        
        if [ $lines -lt 1 ]
        then
            id="001"
        else
            id=`tail -n 1 $userTasksDB | cut -d \: -f 1`
            let id=$id+1
            case ${#id} in
                1)
                    id=00$id
                ;;
                2)
                    id=0$id
                ;;
            esac
        fi
        clear
        echo "%%%%%%%%%%%%%%%%%%%%%"
        echo "     Nueva Tarea     "
        echo "%%%%%%%%%%%%%%%%%%%%%"
        echo
        read -p "Descripcion de la tarea: " description
        
        clear
        echo Resumen:
        echo
        echo "ID: $id"
        echo
        echo "Fecha de creacion: $date"
        echo
        echo "Descripcion: $description"
        echo
        read -p "Desea crear tarea actual? [Y/N]: " create
        
        while [[ ! "$create" == "Y" && ! "$create" == "N" ]]
        do
            clear
            echo "Opción no válida, vuelve a intentarlo"
            read -p "¿Desea crear tarea actual? [Y/N]: " create
        done
        
        if [ "$create" = "Y" ]
        then
            echo "$id:$date:-:$description" >> $userTasksDB
            read -p "Añadir mas tareas? [Y/N]: " continue
        else
            echo "Creacion de tarea cancelada"
            read -p "Reintentar? [Y/N]: " continue
            
        fi
    done
}