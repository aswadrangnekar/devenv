# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

SHARED_DIR = "/opt"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

    config.vm.box = "ubuntu/trusty64"
    config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

    config.vm.provider "virtualbox" do |vm|
        vm.memory = 4096
        vm.cpus = 2
    end

    config.vm.define "devenv", primary: true do |devenv|
        devenv.vm.synced_folder ".", SHARED_DIR
        # auto jump to shared dir on log in
        devenv.vm.provision "shell", inline: "echo 'cd #{SHARED_DIR}' >> /home/vagrant/.bashrc"

        ip_address = "10.2.0.21"
        devenv.vm.network "forwarded_port", guest: 80, host: 5080
        # TODO(aswad): forward Openstack ports if required
        devenv.vm.network "private_network", ip: ip_address

        # TODO(aswad): Modify the setup script to auto setup sn-devstack
        devenv.vm.provision "shell", path: "tools/provision.sh", args: ip_address
    end

end