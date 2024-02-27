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
        read -p "Intrduce nombre de usuario: " username
        stty -echo #Deja de mostrar lo que introduce el usuario
        read -p "Intrduce la contrasena de usuario: " password
        stty echo #Vuelve a mostrar lo que se introduce
        state="true"
        if grep -q "$username" $userDB && grep -q "$password" $userDB
        then
            #Aqui busca si los datos encontrados se encuentran en la misma linea
            linea1=$(grep -n "$username" $userDB | cut -d: -f1) #n de linea del nombre
            linea2=$(grep -n "$password" $userDB | cut -d: -f1) #n de linea de la contrasena
            if [ "$linea1" == "$linea2" ]
            then
                #Metemos dentro de la variable id la id del usuario que se ha buscado en $userDB
                userId=$(sed -n "${linea1}s/^\([0-9]\{3\}\).*$/\1/p" "$userDB")
                #echo $username ha iniciado sesion >> $dailyLog
                #menu.sh $userId
            else
                loginError
            fi
        else
            loginError
        fi
    done
}