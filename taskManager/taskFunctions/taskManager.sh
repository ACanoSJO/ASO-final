#!/bin/bash
#imports
source ./taskFunctions/addTasks.sh
source ./taskFunctions/checkTasks.sh
source ./taskFunctions/deleteTasks.sh
source ./taskFunctions/viewTasks.sh

function taskManager()
{
    userTasksDB="./DB/.$userId-tasks"
    
    if [ ! -e $userTasksDB ]
    then
        clear
        echo "Creando base de datos de tareas..."
        touch $userTasksDB
        stty -echo
        read -p "Pulsa enter para continuar"
        stty echo
    fi
    
    taskManagerOption=0
    while [ $taskManagerOption -ne 5 ]
    do
        clear
        echo "%%%%%%%%%%%%%%%%%%%%%"
        echo "  Gestion de tareas  "
        echo "%%%%%%%%%%%%%%%%%%%%%"
        echo
        echo "1) Ver tareas"
        echo "2) Nueva tarea"
        echo "3) Marcar tarea"
        echo "4) Eliminar tarea"
        echo "5) Cerrar sesion"
        echo
        read -p "Opcion: " taskManagerOption
        
        case $taskManagerOption in
            1)
                viewTasks $userTasksDB
            ;;
            2)
                addTasks $userTasksDB
            ;;
            3)
                checkTasks
            ;;
            4)
                deleteTasks
            ;;
        esac
    done
    clear
}