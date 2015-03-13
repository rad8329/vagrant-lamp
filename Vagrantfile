# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version #
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.vm.box = "ubuntu/trusty64"

    # Forward ports for servers #
    config.vm.network "forwarded_port", guest: 80, host: 8788 #Apache
    config.vm.network "forwarded_port", guest: 3306, host: 8789 #MySQL
    config.vm.network "forwarded_port", guest: 6379, host: 8790 #Redis
	config.vm.network "forwarded_port", guest: 27017, host: 8791 #Mongo

    config.vm.synced_folder "htdocs", "/var/www/html"

	config.vm.provision "shell", path: "provision.sh"

   config.vm.provider "virtualbox" do |vb|
     # Don't boot with headless mode #
     #vb.gui = true
  
     # Use VBoxManage to customize the VM. For example to change memory: #
     vb.customize ["modifyvm", :id, "--memory", "2048"]
   end
end
