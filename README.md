---------
## Backup-escritorio
* Script desarrollado en bash
*********************************************
* Diseñado por SUKIGSX
* Contacto: sukigsx.mbsistemas@gmail.com
*********************************************

Este script esta pensado para realizar backup de la configuracion de tu escritorio.
Esta probado en entorno Gnome y Plasma.
Solo copia la configuracion, NO LOS DATOS.

- Backup de tus iconos.
- Backup de tus ascesos directos en tu escritorio.
- Backup de tus lanzadores, tanto del escritorio como del menu.
- El backup lo puedes realizar en red a un servidor o en local.
- Backup de la configuracion asi como las ventanas y las barras etc...

### INSTALACION.

#### Descargar e instalar el paquete DEB.
- [Descargar el paque DEB](https://github.com/sukigsx/Backup-esritorio/raw/main/Backup-escritorio.deb). Y lo puedes instalar con tu forma habitual.

- Instalar paquete DEB desde linea de comando en la terminal, lo descarga, lo instala y despues borra el paquete DEB.

      wget https://github.com/sukigsx/Backup-esritorio/raw/main/Backup-escritorio.deb; sudo dpkg -i Backup-escritorio.deb; rm Backup-escritorio.deb
  
 - Clonar el repositorio, desde la terminal. Dar permisos de ejecucion a todos los ficheros.

       git clone https://github.com/sukigsx/Backup-esritorio.git

**Nota**. Aconsejo instalar el paquete deb, porque así podrás tener en tu menú de aplicaciones el script con su icono y lo podrás lanzar de forma gráfica sin necesidad de abrir el terminal, además crea una función en el bashrc que al abrir el terminal y escribiendo (scripts), te lista todos mis scripts que tengas instalados en tu sistema que hayas instalado con el paquete deb. Cuando lo desístalas, te pregunta si lo quieres eliminar.

#### Desistalar el paquete deb, desde el terminal.
     sudo dpkg -r backup-escritorio

### Forma de ejecucion.
- Si has clonado el repositorio y con permisos de ejecucion.

      ./Backup-escritorio.sukigsx.sh
- Si has instalado el paquete. Lo encontraras en el lanzador.
  

### NOTA.
Insisto. ¡¡ NO HACE BACKUP DE DATOS !!, solo de configuraciones.
