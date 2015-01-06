# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "ubuntu/trusty64"

  #config.vm.network "forwarded_port", guest: 80, host: 8081

  ## For masterless, mount your salt file root
  config.vm.synced_folder "salt", "/srv/salt/"

  ## Use all the defaults:
  config.vm.provision :salt do |salt|

  salt.minion_config = "salt-config/masterless-minion"
  salt.run_highstate = true

  end

  config.vm.provider "virtualbox" do |v|
    v.memory = 1024
  end
end
