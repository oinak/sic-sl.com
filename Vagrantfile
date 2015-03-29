Vagrant.configure("2") do |vagrant|
  vagrant.vm.define "sic_web" do |config|

    # Inject code from outer FS (edit outside, run inside)
    # required by type: "nfs"
    config.vm.network "private_network", ip: '192.168.50.4'
    config.vm.synced_folder ".", "/home/vagrant/code", type: "nfs"

    # Access app with outer browser
    # otherwise use rails s -b 0.0.0.0 and private ip
    config.vm.network "forwarded_port", guest: 3000, host: 3000

    # livereload
    config.vm.network "forwarded_port", guest: 35729, host: 35729

    config.vm.network "public_network", bridge: 'wlan0'

    # http://rvm.io/integration/vagrant
    config.vm.provision :shell, path: 'provision/bootstrap.sh', keep_color: true

    config.vm.provider "virtualbox" do |vb, override|
      # http://www.vagrantbox.es/
      # Prepare with: wget -O ../trusty-vbox.box http://goo.gl/8wqNnb
      override.vm.box_url = "../trusty-vbox.box"
      override.vm.box     = "trusty-vbox"
      vb.name             = 'sic_web'
      vb.memory           = 1024
      vb.cpus             = 2
      vb.customize ['modifyvm', :id, "--natdnshostresolver1", "on"]
    end
  end
end
