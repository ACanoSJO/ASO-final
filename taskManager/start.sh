#!/bin/bash
#Imports
source taskFunctions/register.sh
source taskFunctions/login.sh
source taskFunctions/taskManager.sh
function start()
{
    userDB="DB/.userDB"
    clear
    startOption=0
    #Comprueba la existencia de .userDB, en caso de que no exista la crea vacia
    if [ ! -e "$userDB" ]
    then
        clear
        echo "Creando userDB..."
        stty -echo
        read -p "Pulsa enter para continuar..."
        stty echo
        # sudo mkdir /usr/local/taskManager
        touch $userDB
        echo id:nombre:contrasena > $userDB
    fi
    
    #Bucle que continua hasta que se elija la opcion de salida
    while [ $startOption -ne 3 ]
    do
        clear
        echo "%%%%%%%%%%%%%%%%%%%%%"
        echo "       Inicio        "
        echo "%%%%%%%%%%%%%%%%%%%%%"
        echo
        echo "1) Registrarse"
        echo "2) Iniciar sesion"
        echo "3) Cerrar programa"
        echo
        read -p "Elige una opcion: " startOption
        clear
        case $startOption in
            1)
                register
            ;;
            2)
                login
                taskManager
            ;;
        esac
    done
    clear
}
start