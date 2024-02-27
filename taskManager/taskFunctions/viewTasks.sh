#!/bin/bash
function viewTasks() {
    clear
    continue="Y"
    while [ "$continue" = "Y" ]
    do
        filter=""
        validFilter="N"
        while [ "$validFilter" = "N" ]
        do
            clear
            echo "Filtrar resultados"
            echo "1) Completas"
            echo "2) Incompletas"
            echo "3) Mostrar todo"
            read -p "Opcion: " filter
            clear
            echo "id:fecha:completa"
            echo ""
            case $filter in
                1)
                    grep :x $1| cut -d\: -f1-3
                    validFilter="Y"
                ;;
                2)
                    grep :- $1| cut -d\: -f1-3
                    validFilter="Y"
                ;;
                3)
                    cat $1 | cut -d\: -f1-3
                    validFilter="Y"
                ;;
                *)
                    validFilter="N"
                ;;
            esac
        done
        echo ""
        stty -echo
        read -p "Pulsa enter para continuar..."
        stty echo
        clear
        inspectTask="Y"
        while [ "$inspectTask" = "Y" ]
        do
            clear
            echo "Quieres ver los detalles de alguna tarea?"
            read -p "[id/N] " taskToInspect
            
            if [ ! "$taskToInspect" = "N" ]
            then
                exist="false"
                lines=$(wc -l < $1)
                i=1
                currentTaskId=""
                while [ $i -le $lines ]
                do
                    currentTaskId=$(head -n $i $1 | tail -n 1 | cut -d \: -f 1)
                    let i=$i+1
                    if [ "$currentTaskId" = "$taskToInspect" ]
                    then
                        exist="true"
                        break
                    fi
                done
                if [ "$exist" = "true" ]
                then
                    clear
                    showId=$(grep $taskToInspect $1 | cut -d\: -f1)
                    showDate=$(grep $taskToInspect $1 | cut -d\: -f2)
                    showComplete=$(grep $taskToInspect $1 | cut -d\: -f3)
                    showDescription=$(grep $taskToInspect $1 | cut -d\: -f4)
                    echo "Id tarea: $showId"
                    echo ""
                    echo "Fecha de creacion: $showDate"
                    echo ""
                    if [ "$showComplete" = "x" ]
                    then
                        echo "La tarea esta completa: $showComplete"
                    else
                        echo "La tarea NO esta completa: $showComplete"
                    fi
                    echo ""
                    echo "Descripcion:"
                    echo "$showDescription"
                    echo ""
                    stty -echo
                    read -p "Pulsa enter para continuar..."
                    stty echo
                    clear
                else
                    inspectTask="N"
                    echo "No existe ninguna tarea con la id $taskToInspect"
                    stty -echo
                    read -p "Pulsa enter para continuar..."
                    stty echo
                    clear
                fi
            else
                inspectTask="N"
                clear
            fi
        done
        
        echo ""
        read -p "Desea continuar? [Y/N]: " continue
        while [[ ! "$continue" == "Y" && ! "$continue" == "N" ]]
        do
            clear
            echo "Opcion no valida, vuelve a intentarlo"
            read -p "Desea continuar? [Y/N]: " continue
        done
    done
}