Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.provision "shell", path: "bootstrap.sh"

  config.vm.define "node1" do |node|
    node.vm.hostname = "node1"
    node.vm.network "private_network", ip: "192.168.10.21"

	  node.vm.provider "virtualbox" do |vb|
	    vb.memory = 4096
    end
  end

end
