# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

SHARED_STACK_DIR = "/opt"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

    config.vm.box = "ubuntu/trusty64"
    config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

    config.vm.provider "virtualbox" do |vm|
       vm.memory = 8192
       vm.cpus = 2
    end

    config.vm.define "devenv", primary: true do |devenv|
        devenv.vm.synced_folder ".", SHARED_STACK_DIR
        # auto jump to shared dir on log in (uncomment if required)
        # devenv.vm.provision "shell", inline: "echo 'cd #{SHARED_DIR}' >> /home/vagrant/.bashrc"

        ip_address = "10.2.0.21"
        # TODO(aswad): add more ports if required
        devenv.vm.network "forwarded_port", guest: 80, host: 8080
        devenv.vm.network "forwarded_port", guest: 5000, host: 5001
        devenv.vm.network "forwarded_port", guest: 35357, host: 35358
        devenv.vm.network "private_network", ip: ip_address

        devenv.vm.provision "shell", path: "tools/bootstrap.sh"
        # devenv.vm.provision "shell", privileged: false, path: "tools/provision.sh", args: ip_address
    end

end