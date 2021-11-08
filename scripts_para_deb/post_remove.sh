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
echo "- ${verde}Se ha desistalado el script.${borra_colores}"
echo ""
echo "- ${amarillo}Si tienes mas scripts mios instalados, selecciona ( N ).${borra_colores}"
read -p "- Deseas borrar los datos a nivel de bashrc? (S/N) -->> " sn
if [ $sn = "S" ] || [ $sn = "s" ]
then 
    echo ""
    echo "-${verde} Funcion a nivel de bashrc, a sido borrada.${borra_colores}"
    sudo rm /etc/bash.bashrc.sukigsx 2>/dev/null
    sudo sed -i '/source/d' /etc/bash.bashrc
    echo "- ${verde}Muchas gracias...${borra_colores}"
    echo ""
else
    echo ""
    echo "- ${verde}Muchas gracias...${borra_colores}"
    echo ""
    exit 
fi
echo ""
