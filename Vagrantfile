# -*- mode: ruby -*-
# vi: set ft=ruby :

ENV['VAGRANT_SERVER_URL'] = 'https://vagrant.elab.pro'
Vagrant.configure("2") do |config|
    config.vm.define "belousovCreateRpm" do |belousovCreateRpm|
        belousovCreateRpm.vm.box = "almalinux/9"              
        belousovCreateRpm.vm.synced_folder "rpmbuild/", "/root/rpmbuild"
        belousovCreateRpm.vm.synced_folder "nginx", "/root/nginx"
        belousovCreateRpm.vm.host_name = "belousovCreateRpm"
        belousovCreateRpm.vm.provision "shell", path: "init.sh"
        belousovCreateRpm.vm.provider "virtualbox" do |vb|
         vb.memory = "1024"
         vb.cpus = "2"
       end 
    end
 end
