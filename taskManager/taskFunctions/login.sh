#!/bin/bash
# login error
function loginError(){
    echo
    read -p "Usuario u Contrasena incorrectos" -t 3
    clear
    state="false"
}
#funcion de inicio de sesion
function login() { #Declara la variable id con el identificador del usuario que inicie sesion
    clear
    echo %%%%%%%%%%%%%%%%%%%%
    echo % INICIO DE SESION %
    echo %%%%%%%%%%%%%%%%%%%%
    echo
    
    #Busca los datos en la base de datos
    state="false"
    while [ "$state" == "false" ]
    do
        read -p "Introduce nombre de usuario: " username
        stty -echo #Deja de mostrar lo que introduce el usuario
        read -p "Introduce la contrasena de usuario: " password
        stty echo #Vuelve a mostrar lo que se introduce
        state="true"
        if grep -q "$username" "$userDB"
        then
            # Extrae la línea correspondiente al usuario
            userLine=$(grep "$username" "$userDB")
            # Extrae la contraseña asociada a ese usuario
            userPassword=$(echo "$userLine" | cut -d ':' -f 3)
            # Compara la contraseña ingresada con la contraseña almacenada
            if [ "$password" == "$userPassword" ]
            then
                clear
                echo "Inicio de sesión exitoso para el usuario $username"
                userId=$(echo "$userLine" | cut -d ':' -f 1)
                stty -echo
                read -p "Pulsa enter para continuar..."
                stty echo
                # Aquí puedes realizar acciones adicionales después del inicio de sesión exitoso
                # menu.sh $userId
            else
                loginError
            fi
        else
            loginError
        fi
    done
}