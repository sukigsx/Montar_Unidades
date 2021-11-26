 #!/bin/bash
 
#colores
rojo="\e[0;31m\033[1m" #rojo
verde="\e[;32m\033[1m" 
azul="\e[0;34m\033[1m"
amarillo="\e[0;33m\033[1m"
rosa="\e[0;35m\033[1m"
turquesa="\e[0;36m\033[1m"
borra_colores="\033[0m\e[0m" #borra colores
#fin de colores

#toma el control de control + c
trap ctrl_c INT
function ctrl_c()
{
clear
figlet -c Gracias por 
figlet -c utilizar mi
figlet -c script
wmctrl -r :ACTIVE: -b remove,maximized_vert,maximized_horz 2>/dev/null 1>/dev/null 0>/dev/null
exit
}
#Fin de control de control c

#funcion de menu principal
function menu(){
while : 
do 
clear
wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz 2>/dev/null 1>/dev/null 0>/dev/null
source /home/$(whoami)/.config_montar_unidades/montar_unidades
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
echo -e " 3. ${azul}Ver carpetas compartidas de tu servidor.${borra_colores}"
echo -e ""
echo -e " 4. ${azul}Resetear toda la configuracion.${borra_colores}"
echo -e ""
echo -e " 5. ${azul}Montar las unidades.${borra_colores}"
echo -e " 6. ${azul}Desmontar todas las unidades.${borra_colores}"
echo -e ""
echo -e " 7. ${azul}Montar las unidades al inicio del sistema. (crontab).${borra_colores}"
echo -e ""
echo -e " 90. ${azul}Ayuda.${borra_colores}"
echo -e ""
echo -e " 99. ${azul}Atras / Salir.${borra_colores}"
echo ""
echo -n " Seleccione una opcion -> "; read opcion
case $opcion in 
    0)  #actualiza el script
        if [ -e /usr/bin/montar_unidades.sukigsx.sh ] #comprueba si se ha instalado el script con el deb, comprobando el fichero /usr/bin/inicio.sukigsx.sh
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
        mkdir /home/$(whoami)/.config_montar_unidades 2>/dev/null 1>/dev/null 0>/dev/null
        nano /home/$(whoami)/.config_montar_unidades/montar_unidades
        source /home/$(whoami)/.config_montar_unidades/montar_unidades 2>/dev/null 1>/dev/null 0>/dev/null
        ;;
        
    2)  #ver direcciones ip de tu red     
        ip=$(route -n | awk '{print $2}' | grep 192) #saca la ip de la puerta de enlace
        if ping -c 3 $ip 2>/dev/null 1>/dev/null 0>/dev/null #comprueba la conexion a la puerta de enlace
        then
            clear
            echo -e ""
            echo -e "${azul} Listado de direcciones ip donde estara tu servidor samba.${verde}"
            echo -e ""
            arp | grep ether | awk '{print $1}' | sed 's/_gateway/ /'
            echo -e "${borra_colores}"
            echo -e "${azul} Pulsa una tecla para continuar.${borra_colores}"
            read pause
        else
            clear
            echo -e ""
            echo -e "${rojo} Imposible conectar a la red lan. ${amarillo}$ip_servidor_samba${rojo}.${borra_colores}"
            echo -e ""
            echo -e "    ${azul}No existe conexion a la red.${borra_colores}"
            echo -e ""
            echo -e " Revisa el fichero de configuracion, opcion 1 del menu."
            echo -e " Pulsa una tecla para continuar."
            read pause
        fi
        ;;
        
    3)  #ver carpetas compartidas de tu servidor
        if [ $configurado = "si" ]
        then
            if smbclient -L //$ip_servidor_samba/ -U=$usuario_servidor_samba%$password_servidor_samba #2>/dev/null 1>/dev/null 0>/dev/null
            then
                clear
                echo -e "\n ${azul}Listado de carpetas compartidas.${borra_colores}"
                echo -e ""
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
                echo -e "${rojo} Imposible conectar con el servidor ${amarillo}$ip_servidor_samba${rojo}.${borra_colores}"
                echo -e ""
                echo -e " Los datos de acceso al servidor son erroneos. Posibles causas:"
                echo -e ""
                echo -e "   1- ${azul}No existe conexion al servidor en la red.${borra_colores}"
                echo -e "   2- ${azul}El usuario esta mal introducido en el fichero de configuracion.${borra_colores}"
                echo -e "   3- ${azul}La password esta mal introducida en el fichero de configuracion.${borra_colores}"
                echo -e "   4- ${azul}Todas las anteriores.${borra_colores}"
                echo -e ""
                echo -e " Revisa el fichero de configuracion, opcion 1 del menu."
                echo -e " Pulsa una tecla para continuar."
                read pause
            fi
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
        for unidad in $carpeta0 $carpeta1 $carpeta2 $carpeta3 $carpeta4 $carpeta5 $carpeta6 $carpeta7 $carpeta8 $carpeta9
        do
            sudo umount /home/$(whoami)/servidor_samba/$unidad 2>/dev/null 1>/dev/null 0>/dev/null
            sleep 2
        done
        sudo rm -r /home/$(whoami)/.config_montar_unidades 2>/dev/null 1>/dev/null 0>/dev/null
        clear
        echo -e ""
        echo -e "${azul} Restauracion completa.${borra_colores}"
        echo -e ""
        echo -e " [${verde}V${borra_colores}] Ficheros de configuracion borrados."
        echo -e ""
        echo -e "${azul} No se borraran las carpetas incluidas en:${borra_colores}"
        echo -e "${amarillo} /home/$(whoami)/servidor_samba/${borra_colores}"
        echo -e ""
        echo -e "${amarillo} Ejecuta el script de nuevo, para empezar de cero.${borra_colores}"
        echo -e ""
        echo -e "${azul} Pulsa una tecla para continuar.${borra_colores}"
        echo -e ""
        exit
        ;;
        
    5)  #Montar las unidades.
        if [ $configurado = "si" ]
        then
            if smbclient -L //$ip_servidor_samba/ -U=$usuario_servidor_samba%$password_servidor_samba 2>/dev/null 1>/dev/null 0>/dev/null
            then
                clear
                echo -e ""
                echo -e "${verde} Montando las unidades.${borra_colores}"
                echo -e ""
                for unidad in $carpeta0 $carpeta1 $carpeta2 $carpeta3 $carpeta4 $carpeta5 $carpeta6 $carpeta7 $carpeta8 $carpeta9
                do
                if smbclient -c ls //$ip_servidor_samba/$unidad/ -U=$usuario_servidor_samba%$password_servidor_samba 2>/dev/null 1>/dev/null 0>/dev/null #comprueba que exista la unudad
                then
                    mkdir /home/$(whoami)/servidor_samba 2>/dev/null 1>/dev/null 0>/dev/null
                    mkdir /home/$(whoami)/servidor_samba/$unidad 2>/dev/null 1>/dev/null 0>/dev/null
                    sudo mount -t cifs  //$ip_servidor_samba/$unidad /home/$(whoami)/servidor_samba/$unidad -o user=$usuario_servidor_samba,password=$password_servidor_samba,uid=$usuario_servidor_samba,gid=$usuario_servidor_samba 2>/dev/null 1>/dev/null 0>/dev/null
                    echo -e " [${verde}V${borra_colores}] Unidad ${verde}$unidad${borra_colores} montada correctamente."
                    sleep 2
                else
                    echo -e " [${rojo}X${borra_colores}] Unidad ${rojo}$unidad${borra_colores} NO montada"
                    sleep 2
                fi
                done
                echo -e ""
                echo -e "${azul} Pulsa una tecla para continuar.${borra_colores}"
                read pasue
            else
                clear
                echo -e ""
                echo -e "${rojo} Imposible conectar con el servidor ${amarillo}$ip_servidor_samba${rojo}.${borra_colores}"
                echo -e ""
                echo -e " Los datos de acceso al servidor son erroneos. Posibles causas:"
                echo -e ""
                echo -e "   1- ${azul}No existe conexion al servidor en la red.${borra_colores}"
                echo -e "   2- ${azul}El usuario esta mal introducido en el fichero de configuracion.${borra_colores}"
                echo -e "   3- ${azul}La password esta mal introducida en el fichero de configuracion.${borra_colores}"
                echo -e "   4- ${azul}Todas las anteriores.${borra_colores}"
                echo -e ""
                echo -e " Revisa el fichero de configuracion, opcion 1 del menu."
                echo -e " Pulsa una tecla para continuar."
                read pause
            fi
            
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
        
    6)  #Desmontar las unidades.
        if [ $configurado = "si" ]
        then
            clear
            echo -e ""
            echo -e "${verde} Desmontando unidades.${borra_colores}"
            echo -e ""
            for unidad in $carpeta0 $carpeta1 $carpeta2 $carpeta3 $carpeta4 $carpeta5 $carpeta6 $carpeta7 $carpeta8 $carpeta9
            do
                if smbclient -c ls //$ip_servidor_samba/$unidad/ -U=$usuario_servidor_samba%$password_servidor_samba 2>/dev/null 1>/dev/null 0>/dev/null #comprueba que exista la unudad
                then
                    sudo umount /home/$(whoami)/servidor_samba/$unidad 2>/dev/null 1>/dev/null 0>/dev/null
                    echo -e " [${verde}V${borra_colores}] Unidad ${verde}$unidad${borra_colores} desmontada correctamente."
                    sleep 2
                else
                    echo -e " [${rojo}X${borra_colores}] Unidad ${rojo}$unidad${borra_colores} NO montada. Imposible desmontar."
                    sleep 2
                fi
                #sudo umount /home/$(whoami)/servidor_samba/$unidad 2>/dev/null 1>/dev/null 0>/dev/null
                #echo -e " [${verde}V${borra_colores}] Unidad ${verde}$unidad${borra_colores} desmontada correctamente."
                #sleep 2
            done
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
        
    7)  #Montar las unidades al inicio del sistema. con crontab
        #crea un fichero script de montaje ( .montar_crontab )
        source /home/$(whoami)/.config_montar_unidades/montar_unidades 
        if [ $configurado = "si" ]
        then
            if smbclient -L //$ip_servidor_samba/ -U=$usuario_servidor_samba%$password_servidor_samba 2>/dev/null 1>/dev/null 0>/dev/null
            then
                clear
                echo -e ""
                echo -e "${verde} Configurando montaje de unidades automatico mediante (crontab).${borra_colores}"
                echo -e ""
                unidades_correctas=0
                for unidad in $carpeta0 $carpeta1 $carpeta2 $carpeta3 $carpeta4 $carpeta5 $carpeta6 $carpeta7 $carpeta8 $carpeta9
                do
                    if smbclient -c ls //$ip_servidor_samba/$unidad/ -U=$usuario_servidor_samba%$password_servidor_samba 2>/dev/null 1>/dev/null 0>/dev/null #comprueba que exista la unudad
                    then
                        
                        echo -e " [${verde}V${borra_colores}] Unidad ${verde}$unidad${borra_colores} incluida a montaje automatico."
                        sleep 2
                    
                    else
                        
                        echo -e " [${rojo}X${borra_colores}] Unidad ${rojo}$unidad${borra_colores} NO disponible. Revisa fichero configuracion, opcion 1."
                        unidades_correctas=1
                        sleep 2
                    
                    fi
                done
            
                
            else
                clear
                echo -e ""
                echo -e "${rojo} Imposible conexion con el servidor samba.${borra_colores}"
                echo -e "${amarillo} Selecciona opcion 1 del menu para configurar.${borra_colores}"
                echo -e ""
                echo -e "${azul} Pulsa una tecla para continuar.${borra_colores}"
                read pasue
            fi
        else
            clear
            echo -e ""
            echo -e "${rojo} Fichero de configuracion NO esta configurado.${borra_colores}"
            echo -e "${amarillo} Selecciona opcion 1 del menu para configurar.${borra_colores}"
            echo -e ""
            echo -e "${azul} Pulsa una tecla para continuar.${borra_colores}"
            read pasue
        fi
        
        #metemos los comando mount y umount a sudoers, para que no pida pass al cargar en crontab
        echo "$(whoami) ALL=(ALL) NOPASSWD: /bin/umount" | sudo EDITOR="tee -a" visudo
        echo "$(whoami) ALL=(ALL) NOPASSWD: /bin/mount" | sudo EDITOR="tee -a" visudo
        
        
        
        #echo "mkdir /home/$(whoami)/servidor_samba 2>/dev/null 1>/dev/null 0>/dev/null" >> /home/$(whoami)/.config_montar_unidades/montar_crontab
        #echo "mkdir /home/$(whoami)/servidor_samba/$unidad 2>/dev/null 1>/dev/null 0>/dev/null" >> /home/$(whoami)/.config_montar_unidades/montar_crontab
        #echo "sudo mount -t cifs  //$ip_servidor_samba/$unidad /home/$(whoami)/servidor_samba/$unidad -o user=$usuario_servidor_samba,password=$password_servidor_samba,uid=$usuario_servidor_samba,gid=$usuario_servidor_samba 2>/dev/null 1>/dev/null 0>/dev/null" >> /home/$(whoami)/.config_montar_unidades/montar_crontab
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
        echo -e " ${amarillo}OPCION NO DISPONIBLE EN EL MENU.    Seleccion 0.1, 2, 3, 4, 5, 6, 90 o 99 ${borra_colores}";
        echo -e " ${amarillo}PRESIONA ENTER PARA CONTINUAR ........${borra_colores}";
        echo "";
        read pause;
        ;;
esac 
done 
}
#fin de funcion menu principal


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
    
for paquete in net-tools figlet smbclient wmctrl git nano cifs-utils  #ponemos el fostware a instalar separado por espacios
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
            
            if [ $paquete = "net-tools" ]
            then
                which arp 2>/dev/null 1>/dev/null 0>/dev/null
                arp=$?
                if [ $arp = "0" ]
                then
                    break
                else
                    echo " Instalando $paquete. Intento $contador/3."
                    sudo apt install $paquete -y 2>/dev/null 1>/dev/null 0>/dev/null
                    let "contador=contador+1" #incrementa la variable contador en 1
                    which arp 2>/dev/null 1>/dev/null 0>/dev/null #comprueba si esta el programa en tu sistema
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
#Fin de verifica software necesario

#comprobando si existe fichero de configuracion
if [ -f /home/$(whoami)/.config_montar_unidades/montar_unidades ]
then
    source /home/$(whoami)/.config_montar_unidades/montar_unidades
else
    mkdir /home/$(whoami)/.config_montar_unidades 2>/dev/null 1>/dev/null 0>/dev/null
    echo "#####################################################################" >> /home/$(whoami)/.config_montar_unidades/montar_unidades
    echo "# INDICA SI ESTA CONFIGURADO, OPCIONES (si,no) defecto (no)" >> /home/$(whoami)/.config_montar_unidades/montar_unidades
    echo "# PONER EN (si) CUANDO LO TENGAS CONFIGURADO." >> /home/$(whoami)/.config_montar_unidades/montar_unidades
    echo "configurado=no" >> /home/$(whoami)/.config_montar_unidades/montar_unidades
    echo "#####################################################################" >> /home/$(whoami)/.config_montar_unidades/montar_unidades
    echo "" >> /home/$(whoami)/.config_montar_unidades/montar_unidades
    echo "" >> /home/$(whoami)/.config_montar_unidades/montar_unidades
    echo "" >> /home/$(whoami)/.config_montar_unidades/montar_unidades
    echo "#####################################################################" >> /home/$(whoami)/.config_montar_unidades/montar_unidades
    echo "# INDICA LOS DATOS DE TU SERVIDOR." >> /home/$(whoami)/.config_montar_unidades/montar_unidades
    echo "ip_servidor_samba=" >> /home/$(whoami)/.config_montar_unidades/montar_unidades
    echo "usuario_servidor_samba=" >> /home/$(whoami)/.config_montar_unidades/montar_unidades
    echo "password_servidor_samba=" >> /home/$(whoami)/.config_montar_unidades/montar_unidades
    echo "#####################################################################" >> /home/$(whoami)/.config_montar_unidades/montar_unidades
    echo "" >> /home/$(whoami)/.config_montar_unidades/montar_unidades
    echo "" >> /home/$(whoami)/.config_montar_unidades/montar_unidades
    echo "#####################################################################" >> /home/$(whoami)/.config_montar_unidades/montar_unidades
    echo "# INDICA LOS NOMBRE DE LAS CARPETAS A MONTAR." >> /home/$(whoami)/.config_montar_unidades/montar_unidades
    echo "carpeta0=" >> /home/$(whoami)/.config_montar_unidades/montar_unidades
    echo "carpeta1=" >> /home/$(whoami)/.config_montar_unidades/montar_unidades
    echo "carpeta2=" >> /home/$(whoami)/.config_montar_unidades/montar_unidades
    echo "carpeta3=" >> /home/$(whoami)/.config_montar_unidades/montar_unidades
    echo "carpeta4=" >> /home/$(whoami)/.config_montar_unidades/montar_unidades
    echo "carpeta5=" >> /home/$(whoami)/.config_montar_unidades/montar_unidades
    echo "carpeta6=" >> /home/$(whoami)/.config_montar_unidades/montar_unidades
    echo "carpeta7=" >> /home/$(whoami)/.config_montar_unidades/montar_unidades
    echo "carpeta8=" >> /home/$(whoami)/.config_montar_unidades/montar_unidades
    echo "carpeta9=" >> /home/$(whoami)/.config_montar_unidades/montar_unidades
    echo "#####################################################################" >> /home/$(whoami)/.config_montar_unidades/montar_unidades
    echo "# GRABA LOS CAMBION Y LISTO." >> /home/$(whoami)/.config_montar_unidades/montar_unidades
    echo "# ACUERDATE DE PONER si EN LA PRIMERA OPCION." >> /home/$(whoami)/.config_montar_unidades/montar_unidades
    source /home/$(whoami)/.config_montar_unidades/montar_unidades
fi
#fin comprobando fichero de configuracion


#comprobando si el fichero de configuracion esta configurado
if [ $configurado = "si" ] 2>/dev/null 1>/dev/null 0>/dev/null
then
    #si es que si, espera el tiempo por si quieres entrar al menu, pasado el tiempo monta las unidades configuradas.
    echo -e "${amarillo} Se montaran las unidades automaticamente.${borra_colores}"
    echo -e "${amarillo} De lo contrario pulsa Enter, para entrar al menu.${borra_colores}"
    if read -t 5 -p "" name
    then
        #muestra el menu 
        menu
    else
        #no muestra el menu pasado el tiempo y monta las unidades del fichero de configuracion
        echo -e ""
        echo -e "${verde} Montando las unidades.${borra_colores}"
        echo -e ""
        for unidad in $carpeta0 $carpeta1 $carpeta2 $carpeta3 $carpeta4 $carpeta5 $carpeta6 $carpeta7 $carpeta8 $carpeta9
        do
            if smbclient -c ls //$ip_servidor_samba/$unidad/ -U=$usuario_servidor_samba%$password_servidor_samba 2>/dev/null 1>/dev/null 0>/dev/null #comprueba que exista la unudad
            then
                mkdir /home/$(whoami)/servidor_samba 2>/dev/null 1>/dev/null 0>/dev/null
                mkdir /home/$(whoami)/servidor_samba/$unidad 2>/dev/null 1>/dev/null 0>/dev/null
                sudo mount -t cifs  //$ip_servidor_samba/$unidad /home/$(whoami)/servidor_samba/$unidad -o user=$usuario_servidor_samba,password=$password_servidor_samba,uid=$usuario_servidor_samba,gid=$usuario_servidor_samba 2>/dev/null 1>/dev/null 0>/dev/null
                echo -e " [${verde}V${borra_colores}] Unidad ${verde}$unidad${borra_colores} montada correctamente."
                sleep 2
            else
                echo -e " [${rojo}X${borra_colores}] Unidad ${rojo}$unidad${borra_colores} NO montada."
                sleep 2
            fi
        done
        ctrl_c
    fi
else
    menu
fi
#fin comprobacion si el fichero de configuracion esta configurado
