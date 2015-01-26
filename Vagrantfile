# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"
MACHINE_NAME = "hhbd-vmx"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

    # Fix to: https://github.com/mitchellh/vagrant/issues/1673
    config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"
    config.ssh.forward_agent = true

    config.omnibus.chef_version = :latest
    config.berkshelf.enabled = true
    config.berkshelf.berksfile_path = "Berksfile"

    config.vm.box = "ubuntu/trusty64"
    config.vm.hostname = MACHINE_NAME

    if Vagrant.has_plugin?("vagrant-cachier")
        # Configure cached packages to be shared between instances of the same base box.
        # More info on http://fgrehm.viewdocs.io/vagrant-cachier/usage
        config.cache.auto_detect = true
        config.cache.scope = :box
    end

    config.vm.provider "virtualbox" do |vb|
        vb.name = MACHINE_NAME

        vb.memory = 1024
        vb.cpus = 1
    end

    # Configure networking
    config.vm.network :private_network, ip: "192.168.99.99"

    # Configure synced folders
    config.vm.synced_folder "../hhbd-app/www", "/var/www/hhbd.pl.vmx/releases/initial"
    config.vm.synced_folder ".", "/vagrant", disabled: true

    # Configure provisioning
    config.vm.provision "chef_solo" do |chef|

        chef.log_level = :warn

        chef.encrypted_data_bag_secret_key_path = './encrypted_data_bag_secret'

        chef.data_bags_path = "./data_bags"
        chef.environments_path = "./environments"
        # chef.environment = "local"

        chef.run_list = [
            # System common
            "recipe[jku-common]",
            "recipe[jku-apache]",
            "recipe[jku-mysql]",
            # System specific (hhbd)
            "recipe[hhbd-app::default]",
            # "recipe[hhbd-backoffice::default]",
            # "recipe[hhbd-content::default]"
        ]

        # Here, overwrite all atributes that were set in recipes
        # 1. authorization - to add vagrant user back to sudoers after 'sudo' cookbook does its magic removing it
        chef.json = {
            "authorization" => {
                "sudo" => {
                    "users" => [ "vagrant" ],
                    "passwordless" => true,
                }
            },
          }
    end
end
