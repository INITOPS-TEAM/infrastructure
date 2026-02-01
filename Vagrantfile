Vagrant.configure("2") do |config|
   config.vm.box = "bento/ubuntu-24.04"
  
    # Application VM 1 
    config.vm.define "app1" do |app1|
      app1.vm.hostname = "app1.local"
      app1.vm.network "private_network", ip: "192.168.56.10"
  
      app1.vm.provider "virtualbox" do |vb|
        vb.memory = "1024"
        vb.cpus = 1
      end

      app1.vm.provision "shell", inline: <<-SHELL
        echo "#{File.read(File.expand_path('~/.ssh/ansible.pub'))}" >> /home/vagrant/.ssh/authorized_keys
      SHELL
    end
  
    # Application VM 2 
    config.vm.define "app2" do |app2|
      app2.vm.hostname = "app2.local"
      app2.vm.network "private_network", ip: "192.168.56.11"
  
      app2.vm.provider "virtualbox" do |vb|
        vb.memory = "1024"
        vb.cpus = 1
      end

      app2.vm.provision "shell", inline: <<-SHELL
        echo "#{File.read(File.expand_path('~/.ssh/ansible.pub'))}" >> /home/vagrant/.ssh/authorized_keys
      SHELL
    end
  
    # Load Balancer
    config.vm.define "lb" do |lb|
      lb.vm.hostname = "lb.local"
      lb.vm.network "private_network", ip: "192.168.56.12"
  
      lb.vm.provider "virtualbox" do |vb|
        vb.memory = "512"
        vb.cpus = 1
      end

      lb.vm.provision "shell", inline: <<-SHELL
        echo "#{File.read(File.expand_path('~/.ssh/ansible.pub'))}" >> /home/vagrant/.ssh/authorized_keys
      SHELL
    end
  
    # PostgreSQL
    config.vm.define "db" do |db|
      db.vm.hostname = "postgres.local"
      db.vm.network "private_network", ip: "192.168.56.13"
  
      db.vm.provider "virtualbox" do |vb|
        vb.memory = "1024"
        vb.cpus = 1
      end

      db.vm.provision "shell", inline: <<-SHELL
        echo "#{File.read(File.expand_path('~/.ssh/ansible.pub'))}" >> /home/vagrant/.ssh/authorized_keys
      SHELL
    end
  
    # Jenkins Master VM
    config.vm.define "jenkins" do |jenkins|
      jenkins.vm.hostname = "jenkins.local"
      jenkins.vm.network "private_network", ip: "192.168.56.14"
      jenkins.vm.network "forwarded_port", guest: 8080, host: 8080
  
      jenkins.vm.provider "virtualbox" do |vb|
        vb.memory = "2048"
        vb.cpus = 2
      end
    end
  
    # Jenkins Agent VM
    config.vm.define "jenkins-agent" do |agent|
      agent.vm.hostname = "jenkins-agent.local"
      agent.vm.network "private_network", ip: "192.168.56.16"
  
      agent.vm.provider "virtualbox" do |vb|
        vb.memory = "1024"
        vb.cpus = 1
      end
  
      agent.vm.boot_timeout = 600
    end
  
    # Consul
    config.vm.define "consul" do |consul|
      consul.vm.hostname = "consul.local"
      consul.vm.network "private_network", ip: "192.168.56.15"
  
      consul.vm.provider "virtualbox" do |vb|
        vb.memory = "512"
        vb.cpus = 1
      end

      consul.vm.provision "shell", inline: <<-SHELL
        echo "#{File.read(File.expand_path('~/.ssh/ansible.pub'))}" >> /home/vagrant/.ssh/authorized_keys
    SHELL
    end
  
  end
  