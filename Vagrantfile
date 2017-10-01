# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.define 'chef' do |chef|
    chef.vm.box = 'bento/centos-7.3'
    chef.vm.network "private_network", ip: '192.168.33.10'

    chef.vm.provider 'virtualbox' do |vb|
      vb.memory = '1024'
      vb.cpus = '1'
    end

    #config.ssh.insert_key = false

    config.vm.provision 'shell', path: 'chef-install.sh'
  end
end
