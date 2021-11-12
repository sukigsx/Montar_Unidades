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

source .montar_unidades

for unidad in $carpeta0 $carpeta1 $carpeta2 $carpeta3
do
    mkdir /home/$(whoami)/servidor_samba
    mkdir /home/$(whoami)/servidor_samba/$unidad 
    sudo mount -t cifs  //$ip_servidor_samba/$unidad /home/$(whoami)/servidor_samba/$unidad -o user=$usuario_servidor_samba,password=$password_servidor_samba,uid=$usuario_servidor_samba,gid=$usuario_servidor_samba

done
