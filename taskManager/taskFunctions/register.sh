#!/bin/bash
function register () {
    exist="true"
    while [ "$exist" == "true" ]
    do
        clear
        echo %%%%%%%%%%%
        echo Registrarse
        echo %%%%%%%%%%%
        echo
        
        read -p "Crea un nombre de usuario: " username
        stty -echo
        read -p "Introduce una contraseña: " passwd1
        echo
        read -p "Introduce de nuevo la contraseña: " passwd2
        stty echo
        echo
        
        lines=`wc -l < $userDB`
        i=1
        exist="false"  # Inicializa exist a falso, si encuentra el nombre de usuario existirá y se cambiará a true
        while [ $i -le $lines ]
        do
            user=`head -n $i $userDB | tail -n 1 | cut -d \: -f 2`
            let i=$i+1
            if [ "$user" = "$username" ]
            then
                exist="true"  # Cambia a true si el usuario existe
                break
            fi
        done
        
        if [ "$exist" = "true" ]
        then
            read -p "Este nombre de usuario ya existe. (Enter para continuar): "
        elif [ "$passwd1" != "$passwd2" ]
        then
            exist="true"  # Vuelve a true si la contraseña no coincide
            read -p "La contraseña no coincide. (Enter para continuar): "
        fi
    done
    
    if [ $lines -eq 1 ]
    then
        echo >> "$userDB"
        echo "001:$username:$passwd1" >> "$userDB"
        echo "¡Registrado con éxito!"
    elif [ -s "$userDB" ]
    then
        lastLine=`tail -n 1 "$userDB"`
        lastId=`echo "$lastLine" | cut -c1-3`
        let id=$lastId+1
        case ${#id} in
            1)
                id=00$id
            ;;
            2)
                id=0$id
            ;;
        esac
        echo "$id:$username:$passwd1" >> "$userDB"
        clear
        echo "¡Usuario registrado con éxito!"
        stty -echo
        read -p "Pulsa enter para continuar..."
        stty echo
    fi
}