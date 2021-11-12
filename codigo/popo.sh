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
    
for paquete in figlet smbclient wmctrl git #ponemos el fostware a instalar separado por espacios
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
wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
while : 
do 
clear
source montar_unidades
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
        echo -e ""
        echo -e "${azul} Listado de direcciones ip donde estara tu servidor samba.${verde}"
        arp | grep ether | awk '{print $1}' | sed 's/_gateway/ /'; echo -e "${borra_colores}"
        read -p " Dime la ip de tu servidor. >> " ip_servidor
        read -p " Dime el usuario. >> " usuario_servidor
        read -s -p " Dime el password de tu servidor. >> " password_servidor
        smbclient -L //$ip_servidor/ -U=$usuario_servidor%$password_servidor >/dev/null 2>&1
        if [ $? = 0 ] #comprueba la conexion con el sevidor samba
        then
            #lista las carpetas del servidor y pregunta cuales quieres montar
            clear
            echo -e "\n ${azul}Listado de carpetas compartidas.${borra_colores}"
            echo -e "${verde}"
            smbclient -L //$ip_servidor/ -U=$usuario_servidor%$password_servidor | grep Disk | awk '{print $1}'
            echo -e "${borra_colores}"
            echo -e ""
            read -p " Nombre carpeta a montar. >> " carpeta1
        else
            echo ""
            echo ""
            echo -e "${rojo} No ha sido posible la conexion con el servidor $ip_servidor.${borra_colores}"
            sleep 3
        fi
        ;;
        
    2)  #ver direcciones ip de tu red
        echo -e ""
        echo -e "${azul} Listado de direcciones ip donde estara tu servidor samba.${verde}"
        arp | grep ether | awk '{print $1}' | sed 's/_gateway/ /'; echo -e "${borra_colores}"
        echo -e ""
        echo -e "${azul} Pulsa una tecla para continuar.${borra_colores}"
        read pause
        ;;
        
    3)  #ver carpetas compartidas de tu servidor
        source .montar_unidades
        if [ .montar_unidaes ]
        then
            clear
            echo -e "\n ${azul}Listado de carpetas compartidas.${borra_colores}"
            echo -e "${verde}"
            smbclient -L //$ip_servidor/ -U=$usuario_servidor%$password_servidor | grep Disk | awk '{print $1}'
            echo -e "${borra_colores}"
            echo -e ""
        else
            echo -e ""
            echo -e "${rojo} Fichero de configuracion NO esta configurado."
            echo -e "${azul} Pulsa una tecla para continuar.${borra_colores}"
            echo -e ""
        fi
        ;;
        
    90) #ayuda 
        echo "has seleccionado la dos"; 
        read p
        ;;
        
    99) #salir
        ctrl_c
        ;;
        
    *)  #se activa cuando se introduce una opcion no controlada del menu
        echo "";
        echo -e " ${amarillo}OPCION NO DISPONIBLE EN EL MENU.    Seleccion 1, 2, 3, 4, 5, 6, 7, 8, 9, 40, 90 o 99 ${borra_colores}";
        echo -e " ${amarillo}PRESIONA ENTER PARA CONTINUAR ........${borra_colores}";
        echo "";
        read pause;
        ;
esac 
done 
















#echo -e " Listado de tus equipos en red :"
#arp | grep ether | awk '{print $1}' | sed 's/_gateway/ /'
#echo -e ""

#read -p " ¿ Direccion del servidor de archivos ? >> " ip_servidor
#read -p " ¿ Nombre de usuario ? >> " nombre_servidor
#read -p " ¿ Password de $nombre_servidor del servidor $ip_servidor ? >> " password_servidor
#smbclient -L //$ip_servidor/ -U=$nombre_servidor%$password_servidor
#read pasue
#if [ $? = 0 ]  
#then
#    echo -e "muy bi"
    #smbclient -L //$ip_servidor/ -U=$nombre_servidor%$password_servidor:
    
#else
#    echo -e " No ha sido posible conectar"
    
#fi
