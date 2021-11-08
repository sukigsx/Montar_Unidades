rojo="\e[0;31m\033[1m" #rojo
verde="\e[;32m\033[1m" 
azul="\e[0;34m\033[1m"
amarillo="\e[0;33m\033[1m"
rosa="\e[0;35m\033[1m"
turquesa="\e[0;36m\033[1m"
borra_colores="\033[0m\e[0m" #borra colores
clear
echo ""
echo "${azul} ███████  ██    ██  ██   ██  ██  ██████    ███████  ██   ██${borra_colores}"
echo "${azul} ██       ██    ██  ██  ██   ██  ██        ██        ██ ██ ${borra_colores}"
echo "${azul} ███████  ██    ██  █████    ██  ██   ███  ███████    ███  ${borra_colores}"
echo "${azul}      ██  ██    ██  ██  ██   ██  ██    ██       ██   ██ ██ ${borra_colores}"
echo "${azul} ███████   ██████   ██   ██  ██   ██████   ███████  ██   ██${borra_colores}"
echo ""
echo "Cuando instalas un script mio. Se genera una funcion a nivel de bashrc"
echo " para que desde un terminal con el comando ( scripts ) puedas ver"
echo " todos los scripts que tienes instalados en tu maquina."
echo ""
if [ -f /etc/bash.bashrc.sukigsx ]
then
    echo " no"
    exit
else
    echo "" >> /etc/bash.bashrc.sukigsx
    echo "# Mete al /etc/bash.bashrc la funcion de ver scripts" >> /etc/bash.bashrc.sukigsx
    echo 'echo "------------------------------------------------------------------"' >> /etc/bash.bashrc.sukigsx
    echo 'echo "-    Ver  Scripts  instalados  de  sukigsx  =  scripts           -"' >> /etc/bash.bashrc.sukigsx
    echo 'echo "------------------------------------------------------------------"' >> /etc/bash.bashrc.sukigsx
    echo 'echo ""' >> /etc/bash.bashrc.sukigsx
    echo "" >> /etc/bash.bashrc.sukigsx
    echo "scripts() {"  >> /etc/bash.bashrc.sukigsx
    echo 'clear' >> /etc/bash.bashrc.sukigsx
    echo "echo '---------------------------- SUKIGSX -----------------------------'" >> /etc/bash.bashrc.sukigsx
    echo "echo '-         LISTADO DE LOS SCRIPTS INSTALADOS EN TU SISTEMA        -'" >> /etc/bash.bashrc.sukigsx
    echo "echo '------------------------------------------------------------------'" >> /etc/bash.bashrc.sukigsx
    echo 'echo ""' >> /etc/bash.bashrc.sukigsx
    echo "ls -l /usr/bin/*.sukigsx.sh | awk '{print "'$9'"}' | awk -F/ '{print "'"[*] "'" "'$4'"}'" >> /etc/bash.bashrc.sukigsx
    echo 'echo ""' >> /etc/bash.bashrc.sukigsx
    echo "echo '------------------------------------------------------------------'" >> /etc/bash.bashrc.sukigsx
    echo "}" >> /etc/bash.bashrc.sukigsx
    echo "" >> /etc/bash.bashrc.sukigsx
               
    #mete al .bashrc la orden de carga del fifhero /etc/bash.bashrc
    echo "source /etc/bash.bashrc.sukigsx" >> /etc/bash.bashrc
fi
