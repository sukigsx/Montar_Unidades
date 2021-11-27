---------
## Montar Unidades
* Script desarrollado en bash
*********************************************
* Diseñado por SUKIGSX
* Contacto: sukigsx.mbsistemas@gmail.com
*********************************************

Este script lo que hace, es automatizar el proceso de montar unidades en tu distro de linux, escanea tu red y busca servidores de archivos que utilizan el protocolo SAMBA.

Te muestra las carpetas compartidas y registra tus datos de acceso para poder montarlas de forma automatica. 

La primera vez que ejecutas el script, te pedira los datos necesarios para su configuracion.

Las siguientes veces que ejecutes el script, las montara automaticamente sin pedirte nada, hay una parte en la que te pide que pulses (enter) y podras entrar al menu.

#### Las opciones del menu son las siguienetes:

**Actualizar el script.** 

Pues esta claro, se actualiza el script si fuera necesario, para aplicar las mejoras del mismo. 

**Ver/editar fichero de configuracion.** 

Esta opcion es simple, carga en el editor nano el fichero de configuracion, en el estan todos los datos de conexion a tu servidor o servidores de ficheros SAMBA. 
Puedes modificar los datos de forma manual, como la direccion ip del servidor, los datos de usuario y password asi como las carpetas a las cuales quieres conectar. 
    Nota. las carpetas o unidades de tu servidor, puedes poner tantas como quieras o tengas en tu servidor en una unica linea y separada por espacios 
      Ejemplo. ( datos1 datos2 videos fotos etc ) 

**Ver direcciones ip de tu red.** 
Con esta opcion podras ver todas las ips que tienes en tu red activas. 

**Ver las carpetas compartidas de tu servidor.** 
Simple, te muestra las carpetas que tienes disponibles en tu servidor SAMBA. 

**Resetear toda la configuracion.** 
 Te permite dejar el script como recien instalado o descargado, borrara el fichero de configuracion, borrara el fichero de carga automatica si es que has configurado 
la opcion 7 del menu, asi como eliminara las lineas del (crontab) y de (sudoers). Vamos lo deja limpio y cuando lo ejecutes tendras que volver a configurar. 

**Montar las unidades.** 
Facil. si has parado el inicio automatico del script para sacar el menu y realizar alguna modificacion, con esta opcion montaras las unidames o carpetas configuradas. 

**Desmontar todas las unidades.** 
Basicamente igual que la opcion 5, pero al reves, lo que hace es desmontar todo lo que tengas montado. 
De todas formas, al estar montadas con mount, si reinicias el equipo, NO se montaran, a no ser que lo tengas configurago con la opcion 7 del menu.

**Montar las unidades al inicio del sistema. (crontab).** 
Con esta opcion, consigues que no tengas que ejecutar el script para montar las unidades o carpetas que tengas configuradas. 
Se crea una orden el el fichero (crontab) que se encarga de montar las unidades o carpetas de tu servidor automaticamente en cada reinicio de tu sistema y tu usuario. 
Hay que tener en cuenta que si lo tienes configurado con una lista de carpetas y un servisor y lo modificas manualmente, esos cambios no se modifican en el inicio del 
sistema, una vez que los cambios esten realizados, tendras que seleccionar la opcion 7 del menu para que lo actualize. 

**Ayuda.** 
JeJe, lo que estas biendo. 

**Atras / Salir.** 
Muy simple, no hace falta decir nada.

### INSTALACION.

#### Descargar e instalar el paquete DEB.
- [Descargar el paque DEB](https://github.com/sukigsx/Backup-esritorio/raw/main/Backup-escritorio.deb). Y lo puedes instalar con tu forma habitual.

- Instalar paquete DEB desde linea de comando en la terminal, lo descarga, lo instala y despues borra el paquete DEB.

      wget https://github.com/sukigsx/Backup-esritorio/raw/main/Backup-escritorio.deb; sudo dpkg -i Backup-escritorio.deb; rm Backup-escritorio.deb
  
 - Clonar el repositorio, desde la terminal. Dar permisos de ejecucion a todos los ficheros.

       git clone https://github.com/sukigsx/Montar_Unidades.git

**Nota**. Aconsejo instalar el paquete deb, porque así podrás tener en tu menú de aplicaciones el script con su icono y lo podrás lanzar de forma gráfica sin necesidad de abrir el terminal, además crea una función en el bashrc que al abrir el terminal y escribiendo (scripts), te lista todos mis scripts que tengas instalados en tu sistema que hayas instalado con el paquete deb. Cuando lo desístalas, te pregunta si lo quieres eliminar.

#### Desistalar el paquete deb, desde el terminal.
    sudo dpkg -r montar-unidades

### Forma de ejecucion.
- Si has clonado el repositorio y con permisos de ejecucion y dentro de la carpeta codido.

      ./montar_unidades.sukigsx.sh
- Si has instalado el paquete. Lo encontraras en el lanzador.
