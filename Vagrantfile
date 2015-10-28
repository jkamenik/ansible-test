Vagrant.require_version ">= 1.5"

Vagrant.configure('2') do |config|
  config.vm.box = 'ubuntu/trusty64'

  config.vm.define 'controller' do
    config.vm.hostname = 'jenkins'

    # ensure the user/group matches the jenkins user
    config.vm.synced_folder ".", "/vagrant", :mount_options => ["uid=5678,gid=65534"]

    config.vm.network "private_network", ip: '192.168.100.10'

    config.vm.provision :shell, path: "controller.sh"

    # config.vm.provider "libvirt" do |v|
    #   v.memory = 2 * 1024 # 2 GB
    # end
  end

  [0, 1].each do |n|
    ip = 100 + n

    config.vm.define "slave#{n}" do
      config.vm.hostname = "slave#{n}"

      config.vm.network "private_network", ip: "192.168.100.#{ip}"

      config.vm.provision :shell, path: 'slave.sh'

      # config.vm.provider "libvirt" do |v|
      #   v.memory = 16 * 1024 # X GB
      #   v.cpus   = 4
      # end
    end
  end
end
