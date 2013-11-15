# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  config.vm.box = 'centos6'
  config.vm.box_url = 'http://puppet-vagrant-boxes.puppetlabs.com/centos-64-x64-vbox4210.box'
  config.vm.network :private_network, :ip => '192.168.2.20'
  config.vm.network "public_network", :bridge => 'en0: Wi-Fi (AirPort)'

  config.vm.provision 'puppet' do |puppet|
    puppet.manifests_path = 'puppet/manifests'
    puppet.manifest_file  = 'site.pp'
    puppet.module_path = 'puppet/modules'
    #puppet.options = ['--verbose --debug']
  end
end