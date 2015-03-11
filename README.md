Vagrant LAMP
============
¿Quiere probar una nueva aplicación web, pero no quiere afectar su sistema actual Apache/PHP/MySQL? 
Aplicaciones como MAMP/XAMPP son grandes, pero es difícil de mantener múltiples aplicaciones web separadas, y con configuraciones propias para cada una.

Si ves que necesitas un web stack completo, pero también uno que sea personalizable, utiliza este proyecto Vagrant.

Requerimientos
------------
* VirtualBox <http://www.virtualbox.com>
* Vagrant <http://www.vagrantup.com>
* Git <http://git-scm.com/>


### Startup
	$ git clone https://rad8329@bitbucket.org/rad8329/lamp-vagrant.git
	$ cd lamp-vagrant
	$ vagrant up

#### Apache
El servidor Apache estará habiltado en <http://localhost>

#### MySQL
Externamente el servidor MySQL estará habiliatdo por el puerto 8889, e internamente en la VM estará habilitado en el puerto usual 3306  o por socket.

`Username:` root
`Password:` root

#### Redis

El servidor Redis estará habiliatdo por el puerto 6379, desde la VM y también externamente.

Detalles técnicos
-----------------
* Ubuntu 14.04 64-bit
* Apache 2
* PHP 5.5 + Composer
* MySQL 5.5
* Redis 2.8.4

La raíz del proyecto estará en la carpeta `htdocs` allí podrá ubicar los archivos de su proyecto.

Para acceder a la VM, lo podrá hacer así

	$ vagrant ssh

Si su sistema operativo es Windows, se sugiere usar [PUTTY](http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html), y estará habilitado el protocolo SSH por el puerto 2222

`Username:` vagrant
`Password:` vagrant