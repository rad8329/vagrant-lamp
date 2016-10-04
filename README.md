Requerimientos
------------
* VirtualBox <http://www.virtualbox.org>
* Vagrant <http://www.vagrantup.com>
* Git <http://git-scm.com/>


### Startup
	$ git clone https://github.com/rad8329/vagrant-lamp.git
	$ cd vagrant-lamp
	$ vagrant up

#### Apache
El servidor Apache estará habiltado en <http://localhost:8788>

#### MySQL
Externamente el servidor MySQL estará habiliatdo por el puerto 8889, e internamente en la VM estará habilitado en el puerto usual 3306  o por socket.

`Username:` root
`Password:` root

#### Redis

Externamente el servidor Redis estará habiliatdo por el puerto 8790, e internamente en la VM estará habilitado en el puerto usual 6379.

#### MongoDB

Externamente el servidor MongoDB estará habiliatdo por el puerto 8791, e internamente en la VM estará habilitado en el puerto usual 27017.

Detalles técnicos
-----------------
* Ubuntu 14.04 64-bit
* Apache 2
* PHP 5.5 + Composer
* MySQL 5.5
* Redis 2.8.4
* MongoDB 2.4.9

La raíz del proyecto estará en la carpeta `htdocs` allí podrá ubicar los archivos de su proyecto.

Para acceder a la VM, lo podrá hacer así

	$ vagrant ssh

Si su sistema operativo es Windows, se sugiere usar [PUTTY](http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html), y estará habilitado el protocolo SSH por el puerto 2222

`Username:` vagrant
`Password:` vagrant
