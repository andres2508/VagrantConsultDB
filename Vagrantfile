# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.define :centos_web do |node|
    node.vm.box = "centos6.4"
    node.vm.network :private_network, ip: "192.168.56.52"
    node.vm.network "public_network", :bridge => "eth2", ip:"192.168.131.52", :auto_config => "false", :netmask => "255.255.255.0"
    node.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "1024","--cpus", "2", "--name", "centos_web" ]
    end
    config.vm.provision :chef_solo do |chef|
    	chef.cookbooks_path = "cookbooks"
    	chef.add_recipe "mirror"
	chef.add_recipe "cherrypy"
    	chef.json = {"aptmirror" => {"server" => "192.168.131.254", "serverip" => "192.168.131.52", "serverport" => "80", "databaseip" => "192.168.131.54"}}
    end

  end

  config.vm.define :centos_db do |db|
    db.vm.box = "centos6.4"
    db.vm.network :private_network, ip: "192.168.56.54"
    db.vm.network "public_network", :bridge => "eth2", ip:"192.168.131.54", :auto_config => "false", :netmask => "255.255.255.0"
    db.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "1024","--cpus", "1", "--name", "centos_db" ]
    end
    config.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = "cookbooks"
      chef.add_recipe "mirror"
      chef.add_recipe "postgres"
      chef.json ={"aptmirror" => {"server" => "192.168.131.254"}}    
    end
  end


end
