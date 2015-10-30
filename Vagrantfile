Vagrant.require_version ">= 1.5"

Vagrant.configure('2') do |config|
  config.vm.box = 'ubuntu/trusty64'

  config.vm.define 'controller' do
    config.vm.hostname = 'jenkins'

    config.vm.network "private_network", ip: '192.168.100.10'

    config.vm.provision :shell, path: "controller.sh"
  end

  [0, 1].each do |n|
    ip = 100 + n

    config.vm.define "slave#{n}" do
      config.vm.hostname = "slave#{n}"

      config.vm.network "private_network", ip: "192.168.100.#{ip}"

      config.vm.provision :shell, path: 'slave.sh'
    end
  end
end
