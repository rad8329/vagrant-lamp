# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version #
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.vm.box = "ubuntu/trusty64"

    # Forward ports to Apache and MySQL #
    config.vm.network "forwarded_port", guest: 80, host: 80
    config.vm.network "forwarded_port", guest: 3306, host: 8789
    config.vm.network "forwarded_port", guest: 6379, host: 6379
	config.vm.network "forwarded_port", guest: 27017, host: 27017

    config.vm.synced_folder "htdocs", "/var/www/html"

	config.vm.provision "shell", path: "provision.sh"

   config.vm.provider "virtualbox" do |vb|
     # Don't boot with headless mode #
	 #vb.gui = true
  
     # Use VBoxManage to customize the VM. For example to change memory: #
     vb.customize ["modifyvm", :id, "--memory", "2048"]
   end
end
