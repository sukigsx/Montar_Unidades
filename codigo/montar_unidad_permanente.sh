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
#####################################################################

#monta unidades permanetes
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
echo -e "-${verde} Nombre del script${borra_colores} < montar_unidad_permanente.sh >                                                                                           -"
echo "-                                                                                                                                             -"
echo -e "-${verde} Funcionamiento.${borra_colores} Monta UNA unidad en tu distribucion de linux de forma PERMANENTE.                                                           -"
echo "-                 Si luego ya no la quieres, tendras que borrarla de fichero /etc/fstab                                                       -"
echo "-----------------------------------------------------------------------------------------------------------------------------------------------"
read -p "- Carpeta del SERVIDOR con su ruta absoluta (ej.//192.168.0.2/carpeta/carpeta) -->> " nombre_carpeta_servidor
read -p "- USUARIO del SERVIDOR -->> " nombre_usuario_servidor
read -p "- PASSWORD del usuario $nombre_usurio_servidor del SERVIDOR -->> " password_usuario_servidor
read -p "- Carpeta destino de tu INSTALACION DE LINUX /mnt/servidor/-->> " nombre_carpeta_destino
echo "-----------------------------------------------------------------------------------------------------------------------------------------------"
echo "- Datos introducidos                                                                                                                          -"
echo "-----------------------------------------------------------------------------------------------------------------------------------------------"
echo -e "- Carpeta destino de tu instalacion de linux ${verde}/mnt/servidor/$nombre_carpeta_destino${borra_colores}"
echo -e "- Nombre carpeta del servidor con su ruta absoluta ${verde}$nombre_carpeta_servidor${borra_colores}"
echo -e "- Nombre de usuario del servidor ${verde}$nombre_usuario_servidor${borra_colores}"
echo -e "- Password, ${verde}no te la muestro${borra_colores} "
echo "----------------------------------------------------------------------------------------------------------------------------------------------"
read -p "- Son correptos los datos? (S/N) -->> " correcto
smbclient -U $nombre_usuario_servidor%$password_usuario_servidor -L //$nombre_carpeta_servidor 0>/dev/null 2>/dev/null 1>/dev/null
if [[ $? = 0 ]] && [[ $correcto = "S" ]]
then
    if [ -d /mnt/servidor/$nombre_carpeta_destino ]
    then
        #copia el fichero fstab a la carpeta temporal /tmp
        cp /etc/fstab /tmp/

        #mete la linea de montaje en el fstab de la carpeta temporal /tmp/fstab
        echo "$nombre_carpeta_servidor /mnt/servidor/$nombre_carpeta_destino cifs username=$nombre_usuario_servidor,password=$password_usuario_servidor,noexec,user,rw,nounix,uid=1000,iocharset=utf8  0   0" >> /tmp/fstab

        #copia de nuevo el fichero fstab a su posicion original ya modificado /etc/fstab
        sudo cp /tmp/fstab /etc/

        #recarga el fichero de montaje fstab con sudo mount -a
        sudo mount -a
        echo ""
        echo ""
        echo "----------------------------------------------------------------------------------------------------------------------------------------------"
        echo -e "-${verde}                  Unidad de servidor montada y lista situada en /mnt/servidor/$nombre_carpeta_destino.${borra_colores}"
        echo -e "-${verde}                  Pulsa tecla para continuar.${borra_colores}"
        echo "----------------------------------------------------------------------------------------------------------------------------------------------"
        read pause
        ctrl_c
    else
        #Crea carpeta servidor dentro de /mnt
        sudo mkdir /mnt/servidor
        sudo mkdir /mnt/servidor/$nombre_carpeta_destino

        #copia el fichero fstab a la carpeta temporal /tmp
        cp /etc/fstab /tmp/

        #mete la linea de montaje en el fstab de la carpeta temporal /tmp/fstab
        echo "$nombre_carpeta_servidor /mnt/servidor/$nombre_carpeta_destino cifs username=$nombre_usuario_servidor,password=$password_usuario_servidor,noexec,user,rw,nounix,uid=1000,iocharset=utf8  0   0" >> /tmp/fstab

        #copia de nuevo el fichero fstab a su posicion original ya modificado /etc/fstab
        sudo cp /tmp/fstab /etc/

        #recarga el fichero de montaje fstab con sudo mount -a
        sudo mount -a
        echo ""
        echo ""
        echo "----------------------------------------------------------------------------------------------------------------------------------------------"
        echo -e "-${verde}                  Unidad de servidor montada y lista situada en /mnt/servidor/$nombre_carpeta_destino.${borra_colores}"
        echo -e "-${verde}                  Pulsa tecla para continuar.${borra_colores}"
        echo "----------------------------------------------------------------------------------------------------------------------------------------------"
        read pause
        ctrl_c
    fi
else
clear
echo "-----------------------------------------------------------------------------------------------------------------------------------------------"
echo -e "${amarillo}                          Has seleccionado N o NO hay acceso a la unidad de red.${borra_colores}"
echo -e "${amarillo}                          Saliendo, ejecuta de nuevo si quieres volver a intentar.${borra_colores}"
echo "-----------------------------------------------------------------------------------------------------------------------------------------------"
sleep 3
ctrl_c
fi
