# -*- mode: ruby -*-
# vi: set ft=ruby :


Vagrant.configure("2") do |config|
  config.vm.provider :libvirt do |domain|
    domain.management_network_address = "10.255.1.0/24"
    domain.management_network_name = "wbr1"
    domain.nic_adapter_count = 130
  end
  #Generating Ansible Host File at following location:
  #    ./.vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory
   config.vm.provision "ansible" do |ansible|
     ansible.playbook = "./helper_scripts/empty_playbook.yml"
   end

  config.trigger.after :destroy do
     puts "Removing known host entries"
     `rm -f ~/.ssh/known_hosts`
  end

  ##### DEFINE VM for asa-1 #####
  config.vm.define "asa-1" do |device|
    device.vm.box = "asav"

    device.vm.provider :libvirt do |v|
      v.memory = 4096
      v.nic_model_type = "e1000"
    end
  config.vm.synced_folder '.', '/vagrant', disabled: true

    # NETWORK INTERFACES
      # link for Gig00 --> rtr-1:Gig01
      device.vm.network "private_network",
            :mac => "a0:00:00:00:00:21",
            :libvirt__tunnel_type => 'udp',
            :libvirt__tunnel_local_ip => '127.0.0.1',
            :libvirt__tunnel_local_port => '8013',
            :libvirt__tunnel_ip => '127.0.0.1',
            :libvirt__tunnel_port => '9013',
            :libvirt__iface_name => 'Gig00',
            auto_config: false

      # link for Gig01 --> rtr-2:Gig01
      device.vm.network "private_network",
            :mac => "a0:00:00:00:00:22",
            :libvirt__tunnel_type => 'udp',
            :libvirt__tunnel_local_ip => '127.0.0.1',
            :libvirt__tunnel_local_port => '8014',
            :libvirt__tunnel_ip => '127.0.0.1',
            :libvirt__tunnel_port => '9014',
            :libvirt__iface_name => 'Gig01',
            auto_config: false

  config.vm.boot_timeout = 400

  config.ssh.forward_agent = true
  config.ssh.guest_port = 22
  config.ssh.insert_key = false
  
end
  
  ##### DEFINE VM for rtr-1 #####

  config.vm.define "rtr-1" do |device|
    device.vm.box = "iosv3"

    device.vm.provider :libvirt do |v|
      v.memory = 2048
      v.nic_model_type = "e1000"
    end
  config.vm.synced_folder '.', '/vagrant', disabled: true

    # NETWORK INTERFACES
      # link for Gig01 --> asa-1:Gig00
      device.vm.network "private_network",
            :mac => "a0:00:00:00:00:01",
            :libvirt__tunnel_type => 'udp',
            :libvirt__tunnel_local_ip => '127.0.0.1',
            :libvirt__tunnel_local_port => '9013',
            :libvirt__tunnel_ip => '127.0.0.1',
            :libvirt__tunnel_port => '8013',
            :libvirt__iface_name => 'Gig01',
            auto_config: false

  config.vm.boot_timeout = 400

  config.ssh.forward_agent = true
  config.ssh.guest_port = 22
  config.ssh.insert_key = false

end            
             
  ##### DEFINE VM for rtr-2 #####

  config.vm.define "rtr-2" do |device|
    device.vm.box = "iosv3"

    device.vm.provider :libvirt do |v|
      v.memory = 2048
      v.nic_model_type = "e1000"
    end
  config.vm.synced_folder '.', '/vagrant', disabled: true

    # NETWORK INTERFACES
      # link for Gig01 --> asa-1:Gig01
      device.vm.network "private_network",
            :mac => "a0:00:00:00:00:02",
            :libvirt__tunnel_type => 'udp',
            :libvirt__tunnel_local_ip => '127.0.0.1',
            :libvirt__tunnel_local_port => '9014',
            :libvirt__tunnel_ip => '127.0.0.1',
            :libvirt__tunnel_port => '8014',
            :libvirt__iface_name => 'Gig01',
            auto_config: false

  config.vm.boot_timeout = 400

  config.ssh.forward_agent = true
  config.ssh.guest_port = 22
  config.ssh.insert_key = false

end    

end
  
