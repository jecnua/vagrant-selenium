# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

# Automatically upgrade virtual box guest additions if vbguest plugin is installed or not
VBGUEST_AUTO = ENV["V_VBGUEST_AUTO"] || "1"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  #Define name
  config.vm.define "selenium01" do |selenium01|
    selenium01.vm.network "private_network", ip: "192.168.3.2"
    selenium01.vm.provider "vmware_fusion" do |vmware|
      vmware.vmx["memsize"] = "4096"
      vmware.customize ["modifyvm", :id, "--cpus", "1"]
    end
    selenium01.vm.provider "virtualbox" do |virtualbox|
      virtualbox.memory = 4096
      virtualbox.cpus = 1
    end
    selenium01.vm.box = "ubuntu/trusty64"
    selenium01.vm.host_name = "selenium01.vm"
    selenium01.vm.provision "shell", path: "shell/bootstrap_ubuntu.sh"
  end

  if Vagrant.has_plugin?("vagrant-vbguest")
    unless VBGUEST_AUTO == "1"
      puts "Skipping vbguest auto update"
      config.vbguest.auto_update = false
    end
  else
    puts "Installing vagrant-vbguest plugin is highly recommended!"
  end
end
