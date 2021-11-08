#!/bin/bash
#forma de utilizar los colores en echo
#echo -e "${rojo}Estes es el texto en rojo.${borra_colores"
#colores
rojo="\e[0;31m\033[1m" #rojo
verde="\e[;32m\033[1m" 
azul="\e[0;34m\033[1m"
amarillo="\e[0;33m\033[1m"
rosa="\e[0;35m\033[1m"
turquesa="\e[0;36m\033[1m"
borra_colores="\033[0m\e[0m" #borra colores
###################################################################################################
#toma el control al pulsar control + c
trap ctrl_c INT
function ctrl_c()
{
clear
echo "-----------------------------------------------------------------------------------------------------------------------------------------------"
echo "-                                          ___                     _                                                                          -"
echo "-                                         / __|  ___   ____   __  (_)  ____   ___    ____   ___   _ _                                         -"
echo "-                                        | (_ | |  _| / _  | / _| | | / _  | (_-<   |  _ \ / _ \ |  _|                                        -"
echo "-                                         \___| |_|   \____| \__| |_| \____| /__/   | .__/ \___/ |_|                                          -"
echo "-                                                                                   |_|                                                       -"
echo "-                            _   _   _     _   _   _                               _                     _          _                         -"
echo "-                           | | | | | |_  (_) | | (_)  ___  ____   _ _     ____   (_)    ___  __   _ _  (_)  ____  | |_                       -"
echo "-                           | |_| | |  _| | | | | | | |_ / / _  | |  _|   |    \  | |   (_-< / _| |  _| | | |  _ \ |  _|                      -"
echo "-                            \___/   \__| |_| |_| |_| /__| \____| |_|     |_|_|_| |_|   /__/ \__| |_|   |_| |  __/  \__|                      -"
echo "-                                                                                                           |_|                               -"
echo "-----------------------------------------------------------------------------------------------------------------------------------------------"
exit
}
##################################

 #monta unidades de red en linus, en la carpeta /mnt
 #al salir borra la carpeta
clear
echo "-----------------------------------------------------------------------------------------------------------------------------------------------"
echo "|                                                                                                                                             |"
echo "|                          ███████        ██    ██        ██   ██        ██         ██████         ███████        ██   ██                     |"
echo "|                          ██             ██    ██        ██  ██         ██        ██              ██              ██ ██                      |"
echo "|                          ███████        ██    ██        █████          ██        ██   ███        ███████          ███                       |"
echo "|                               ██        ██    ██        ██  ██         ██        ██    ██             ██         ██ ██                      |"
echo "|                          ███████         ██████         ██   ██        ██         ██████         ███████        ██   ██                     |"
echo "|                                                                                                                                             |"
echo "-----------------------------------------------------------------------------------------------------------------------------------------------"
echo -e "-${verde}  Diseñado por sukigsx / Contacto: | sukisx@reparaciondesistemas.com  |${borra_colores}                          Para mejor visualizacion, presiona F11.     -"
echo -e "-${verde}                                   | www.reparaciondesistemas.com     |${borra_colores}                          Control + C -->> finalizar script.          -"
echo "-----------------------------------------------------------------------------------------------------------------------------------------------"
echo -e "-${verde} Nombre del script${borra_colores} <montar_unidad_temporal.sh>                                                                                               -"
echo "-                                                                                                                                             -"
echo -e "-${verde} Funcionamiento.${borra_colores} Monta una unidad de red de forma TEMPORAL en tu distribucion de linux                                                       -"
echo "-                 dentro de la ruta /mnt                                                                                                      -"
echo "-----------------------------------------------------------------------------------------------------------------------------------------------"
echo "- 1. Te pedira la ruta a absoluta a montar, ej, //192.168.1.100/direcion_la_carpeta__montar.                                                  -"
echo "- 2. Te pedira el nombre de usuario, ej oscar.                                                                                                -"
echo "- 3. Te pedira el nombre de carpeta destino y se montara en /mnt/nombre_de_carpeta.                                                           -"
echo "-----------------------------------------------------------------------------------------------------------------------------------------------"
read -p "- Carpeta del SERVIDOR con su ruta absoluta (ej.//192.168.0.2/carpeta/carpeta) -->> " nombre_carpeta_servidor
read -p "- USUARIO del SERVIDOR -->> " nombre_usuario_servidor
read -p "- PASSWORD del usuario $nombre_usurio_servidor del SERVIDOR -->> " password_usuario_servidor
read -p "- Carpeta destino de tu INSTALACION DE LINUX /mnt/servidor/-->> " nombre_carpeta_destino
echo "-----------------------------------------------------------------------------------------------------------------------------------------------"
echo "- Datos introducidos                                                                                                                          -"
echo "-----------------------------------------------------------------------------------------------------------------------------------------------"
echo -e "- Carpeta destino de tu instalacion de linux ${verde}/mnt/$nombre_carpeta_destino${borra_colores}"
echo -e "- Nombre carpeta del servidor con su ruta absoluta ${verde}$nombre_carpeta_servidor${borra_colores}"
echo -e "- Nombre de usuario del servidor ${verde}$nombre_usuario_servidor${borra_colores}"
echo -e "- Password, ${verde}no te la muestro${borra_colores} "
echo "----------------------------------------------------------------------------------------------------------------------------------------------"
read -p "- Son correptos los datos? (S/N) -->> " correcto

smbclient -U $nombre_usuario_servidor%$password_usuario_servidor -L //$nombre_carpeta_servidor 0>/dev/null 2>/dev/null 1>/dev/null
if [[ $? = 0 ]] && [[ $correcto = "S" ]]
    then
        if [ -d /mnt/$nombre_carpeta_destino ]
        then
            echo "-----------------------------------------------------------------------------------------------------------------------------------------------"
            echo -e "- ${amarillo}LA RUTA DESTINO SELECCIONADA /mnt/$nombre_carpeta_destino YA EXISTE.${borra_colores}"
            echo -e "- ${amarillo}Pulsa una tecla para salir y ejecuta de nuevo el script.${borra_colores}                                                                                     -"
            echo "-----------------------------------------------------------------------------------------------------------------------------------------------"
            read pause
            ctrl_c
        else
            sudo mkdir /mnt/$nombre_carpeta_destino
            sudo mount -t cifs $nombre_carpeta_servidor /mnt/$nombre_carpeta_destino -o user=$nombre_usuario_servidor,uid=$nombre_usuario_servidor,gid=$nombre_usuario_servidor
            echo "-----------------------------------------------------------------------------------------------------------------------------------------------"
            echo -e "-   ${verde}                    Unidad montada, pulsa una tecla para salir y desmontar la unidad. ${borra_colores}                                                    -"
            echo -e "-   ${verde}                                Para mejor visualizacion, presiona F11     ${borra_colores}                                                               -"
            echo "-----------------------------------------------------------------------------------------------------------------------------------------------"
            read pause
            sudo umount /mnt/$nombre_carpeta_destino
            sudo rmdir /mnt/$nombre_carpeta_destino
            ctrl_c
        fi
        
    else
        clear
        echo "-----------------------------------------------------------------------------------------------------------------------------------------------"
        echo -e "${amarillo}                          Has seleccionado N o NO hay acceso a la unidad de red.${borra_colores}"
        echo -e "${amarillo}                          Saliendo, ejecuta de nuevo si quieres volver a intentar.${borra_colores}"
        echo "-----------------------------------------------------------------------------------------------------------------------------------------------"
        read pause
fi
ctrl_c
