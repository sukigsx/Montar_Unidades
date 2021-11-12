 #!/bin/bash

#colores
rojo="\e[0;31m\033[1m" #rojo
verde="\e[;32m\033[1m" 
azul="\e[0;34m\033[1m"
amarillo="\e[0;33m\033[1m"
rosa="\e[0;35m\033[1m"
turquesa="\e[0;36m\033[1m"
borra_colores="\033[0m\e[0m" #borra colores

#toma el control de control + c
trap ctrl_c INT
function ctrl_c()
{
clear
figlet -c Gracias por 
figlet -c utilizar mi
figlet -c script
wmctrl -r :ACTIVE: -b remove,maximized_vert,maximized_horz
exit
}

#verifica el software necesario
clear
echo -e ""
echo -e "${verde} Verificando software necesario.${borra_colores}"
echo -e ""
## Vericica conexion a internet
    if ping -c1 google.com &>/dev/null;
    then
        echo -e " [${verde}ok${borra_colores}] Conexion a internet."
        conexion="si" #sabemos si tenemos conexion a internet o no
    else
        echo -e " [${rojo}XX${borra_colores}] Conexion a internet."
        conexion="no" #sabemos si tenemos conexion a internet o no
    fi
    
for paquete in figlet smbclient wmctrl git nano cifs-utils #ponemos el fostware a instalar separado por espacios
do
    which $paquete 2>/dev/null 1>/dev/null 0>/dev/null #comprueba si esta el programa llamado programa
    sino=$? #recojemos el 0 o 1 del resultado de which
    contador="1" #ponemos la variable contador a 1
    while [ $sino -gt 0 ] #entra en el bicle si variable programa es 0, no lo ha encontrado which
    do
        if [ $contador = "4" ] || [ $conexion = "no" ] #si el contador es 4 entre en then y sino en else
        then #si entra en then es porque el contador es igual a 4 y no ha podido instalar o no hay conexion a internet
            echo ""
            echo -e " ${amarillo}NO se ha podido instalar ($paquete).${borra_colores}"
            echo -e " ${amarillo}Intentelo usted con la orden:${borra_colores}"
            echo -e " ${rojo}-- sudo apt install $paquete --${borra_colores}"
            echo -e ""
            echo -e " ${rojo}No se puede ejecutar el script.${borra_colores}"
            echo ""
            exit
        else #intenta instalar
            if [ $paquete = "cifs-utils" ]
            then
                which cifscreds 2>/dev/null 1>/dev/null 0>/dev/null
                cifscreds=$?
                if [ $cifscreds = "0" ]
                then
                    break
                else
                    echo " Instalando $paquete. Intento $contador/3."
                    sudo apt install $paquete -y 2>/dev/null 1>/dev/null 0>/dev/null
                    let "contador=contador+1" #incrementa la variable contador en 1
                    which cifscreds 2>/dev/null 1>/dev/null 0>/dev/null #comprueba si esta el programa en tu sistema
                    sino=$? ##recojemos el 0 o 1 del resultado de which
                fi
            else
                echo -e ""
            fi
            echo " Instalando $paquete. Intento $contador/3."
            sudo apt install $paquete -y 2>/dev/null 1>/dev/null 0>/dev/null
            let "contador=contador+1" #incrementa la variable contador en 1
            which $paquete 2>/dev/null 1>/dev/null 0>/dev/null #comprueba si esta el programa en tu sistema
            sino=$? ##recojemos el 0 o 1 del resultado de which
        fi
done
    echo -e " [${verde}ok${borra_colores}] $paquete."

done
echo -e ""
echo -e "${verde} Continuamos...${borra_colores}"
sleep 2




#empieza lo gordo

function menu(){
while : 
do 
clear
source .montar_unidades
echo -e "${rosa}"; figlet -c sukigsx; echo -e "${borra_colores}"
echo -e""
echo -e "${verde} Diseñado por sukigsx / Contacto:  sukisx.mbsistemas@gmail.com${borra_colores}"
echo -e "${verde}                                   https://mbsistemas.ddns.net${borra_colores}"
echo -e ""
echo -e "${verde} Nombre del script < montar_unidades.sukigsx.sh >${borra_colores}"
echo -e ""
if [ $configurado = "si" ]
then
    echo -e "${azul} Estado de la configuracion del script. Configurado = ${verde}$configurado${borra_colores}."
else
    echo -e "${azul} Estado de la configuracion del script. Configurado = ${rojo}$configurado${borra_colores}."
fi
echo -e ""
echo -e " 0.${azul} Actualiza este scripts.${borra_colores} >> ${turquesa}Actualizacion a la ultima version.${borra_colores}"
echo ""
echo -e " 1. ${azul}Ver/editar fichero de configuracion.${borra_colores}"
echo -e ""
echo -e " 2. ${azul}Ver direcciones ip de tu red.${borra_colores}"
echo -e ""
echo -e " 3. ${azul}Ver carpetas compartidas de tu servidor.${borra_colores}"
echo -e ""
echo -e " 4. ${azul}Resetear toda la configuracion.${borra_colores}"
echo -e ""
echo -e " 5. ${azul}Montar las unidades.${borra_colores}"
echo -e ""
echo -e " 6. ${azul}Desmontar todas las unidades.${borra_colores}"
echo -e ""
echo -e " 90. ${azul}Ayuda.${borra_colores}"
echo -e ""
echo -e " 99. ${azul}Atras / Salir.${borra_colores}"
echo ""
echo -n " Seleccione una opcion --->>> "; read opcion
case $opcion in 
    0)  #actualiza el script
        if [ -e /usr/bin/inicio.sukigsx.sh ] #comprueba si se ha instalado el script con el deb, comprobando el fichero /usr/bin/inicio.sukigsx.sh
        then
            ruta="/usr/bin"
            cd /tmp
            mkdir temporal_update
            git clone https://github.com/sukigsx/Instalacion-software.git /tmp/temporal_update
            cd /tmp/temporal_update/codigo/
            sudo chmod +x $ruta/*.sukigsx.sh
            sudo cp -r /tmp/temporal_update/codigo/* $ruta
            sudo rm -r /tmp/temporal_update
            clear
            echo "";
            echo -e "${verde} Script actualizado. Tienes que reiniciar el script para ver los cambios.${borra_colores}";
            echo "";
            read -p " Pulsa una tecla para continuar." pause
            ctrl_c;
        else
            ruta=$(pwd)
            cd /tmp
            mkdir temporal_update
            git clone https://github.com/sukigsx/Instalacion-software.git /tmp/temporal_update
            cd /tmp/temporal_update/codigo/
            sudo chmod +x $ruta/*.sukigsx.sh
            sudo cp -r /tmp/temporal_update/codigo/* $ruta
            sudo rm -r /tmp/temporal_update
            clear
            echo "";
            echo -e "${verde} Script actualizado. Tienes que reiniciar el script para ver los cambios.${borra_colores}";
            echo "";
            read -p " Pulsa una tecla para continuar." pause
            ctrl_c;
        fi;; 
        
    1)  #configuracion
        clear
        nano .montar_unidades
        ;;
        
    2)  #ver direcciones ip de tu red
        clear
        echo -e ""
        echo -e "${azul} Listado de direcciones ip donde estara tu servidor samba.${verde}"
        arp | grep ether | awk '{print $1}' | sed 's/_gateway/ /'
        echo -e "${borra_colores}"
        echo -e "${azul} Pulsa una tecla para continuar.${borra_colores}"
        read pause
        ;;
        
    3)  #ver carpetas compartidas de tu servidor
        source .montar_unidades
        if [ $configurado = "si" ]
        then
            clear
            echo -e "\n ${azul}Listado de carpetas compartidas.${borra_colores}"
            echo -e "${verde}"
            smbclient -L //$ip_servidor_samba/ -U=$usuario_servidor_samba%$password_servidor_samba | grep Disk | awk '{print " -    " $1}'
            echo -e ""
            echo -e "${azul} Fin del listado de las carpetas de tu servidor samba.${borra_colores}"
            echo -e ""
            echo -e "${azul} Pulsa una tecla para continuar.${borra_colores}"
            read pasue
        else
            clear
            echo -e ""
            echo -e "${rojo} Fichero de configuracion NO esta configurado.${borra_colores}"
            echo -e "${amarillo} Selecciona opcion 1 del menu para configurar.${borra_colores}"
            echo -e ""
            echo -e "${azul} Pulsa una tecla para continuar.${borra_colores}"
            read pasue
        fi
        ;;
        
    4)  #Resetear toda la configuracion
        ;;
        
    5)  #Montar las unidades.
        ;;
        
    6)  #Desmontar las unidades.
        ;;
        
    90) #ayuda 
        echo "ayuda"; 
        read p
        ;;
        
    99) #salir
        ctrl_c
        ;;
        
    *)  #se activa cuando se introduce una opcion no controlada del menu
        echo "";
        echo -e " ${amarillo}OPCION NO DISPONIBLE EN EL MENU.    Seleccion 0.1, 2, 3, 90 o 99 ${borra_colores}";
        echo -e " ${amarillo}PRESIONA ENTER PARA CONTINUAR ........${borra_colores}";
        echo "";
        read pause;
        ;;
esac 
done 
}

clear
wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
echo -e "${rosa}"; figlet -c sukigsx; echo -e "${borra_colores}"
echo -e""
echo -e "${verde} Diseñado por sukigsx / Contacto:  sukisx.mbsistemas@gmail.com${borra_colores}"
echo -e "${verde}                                   https://mbsistemas.ddns.net${borra_colores}"
echo -e ""
echo -e "${verde} Nombre del script < montar_unidades.sukigsx.sh >${borra_colores}"
echo -e ""
source .montar_unidades
if [ $configurado = "si" ] #comprueba si esta configurado
then
    if read -t 5 -p " Ver menu de opciones, pulsa enter: " name
    then
        #muestra el menu 
        menu
    else
        #no muestra el menu pasado el tiempo y monta las unidades del fichero de configuracion
        clear
        echo -e "${verde} Montando unidades.${borra_colores}"
        echo -e ""
        for unidad in $carpeta0 $carpeta1 $carpeta2 $carpeta3
        do
            mkdir /home/$(whoami)/servidor_samba 2>/dev/null 1>/dev/null 0>/dev/null
            mkdir /home/$(whoami)/servidor_samba/$unidad 2>/dev/null 1>/dev/null 0>/dev/null
            sudo mount -t cifs  //$ip_servidor_samba/$unidad /home/$(whoami)/servidor_samba/$unidad -o user=$usuario_servidor_samba,password=$password_servidor_samba,uid=$usuario_servidor_samba,gid=$usuario_servidor_samba
            echo -e " Unidad ${verde}$unidad${borra_colores} montada."
        done
        read pasue
        ctrl_c
    fi 
else
    #no esta configurado, muestra el menu
    menu
fi

