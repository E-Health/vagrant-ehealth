# -*- mode: ruby -*-
# vi: set ft=ruby :

$script = <<SCRIPT
  echo I am starting mysql...
  /etc/init.d/mysql start

  #echo I am getting OSCAR for you...
  #wget -P -q /home/vagrant/code/ http://downloads.sourceforge.net/project/oscarmcmaster/Oscar%20Debian%2BUbuntu%20deb%20Package/oscar_emr12.1.2-70general538.deb

  echo I am installing OSCAR for you...
  export DEBIAN_FRONTEND=noninteractive
  URL='http://downloads.sourceforge.net/project/oscarmcmaster/Oscar%20Debian%2BUbuntu%20deb%20Package/oscar_emr12.1.2-70general538.deb'; FILE=`mktemp`; wget "$URL" -qO $FILE && dpkg -i $FILE; rm $FILE

  echo I am installing R Studio server for you...
  URL='https://download2.rstudio.org/rstudio-server-0.99.473-i386.deb'; FILE=`mktemp`; wget "$URL" -qO $FILE && dpkg -i $FILE; rm $FILE

  echo I am installing R packages for you...
  #/home/vagrant/install.r JGR Deducer DeducerExtras nortest lawstat
  /home/vagrant/install.r nortest lawstat


SCRIPT

$r_latest = <<SCRIPT2

  echo I am getting latest R for you...
  echo "deb http://cran.utstat.utoronto.ca/bin/linux/ubuntu trusty/" | sudo tee -a /etc/apt/sources.list > /dev/null
  sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
  sudo add-apt-repository ppa:marutter/rdev
  sudo apt-get -y update
  sudo apt-get -y upgrade
  sudo apt-get -y install r-base r-base-dev

SCRIPT2

Vagrant.configure("2") do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box = "ubuntu/trusty32"
  config.vm.boot_timeout = 900
  config.ssh.insert_key = false


  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  #config.vm.box_url = "http://vagrant.boxes.lwndev.s3.amazonaws.com/quantal64.box"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine.
  config.vm.network "forwarded_port", guest: 80, host: 8000, auto_correct: true
  config.vm.network "forwarded_port", guest: 8080, host: 8001, auto_correct: true
  config.vm.network "forwarded_port", guest: 8787, host: 8002, auto_correct: true
  config.vm.network "forwarded_port", guest: 8443, host: 8003, auto_correct: true

  # Share an additional folder to the guest VM. The first argument is
  # an identifier, the second is the path on the guest to mount the
  # folder, and the third is the path on the host to the actual folder.
  config.vm.synced_folder "code", "/home/vagrant/code", :create => true

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  #config.vm.network :private_network, ip: "192.168.40.10"

  config.vm.provider "virtualbox" do |v|
    v.name = "ehealth"
    v.customize [
       "modifyvm", :id,
       "--name", "ehealth",
       "--memory", "1024"]
    #v.gui = true
  end

  config.vm.provision "shell", inline: $r_latest


  config.vm.provision :puppet do |puppet|
    puppet.module_path = "modules"
    puppet.manifests_path = "manifests"
    puppet.manifest_file  = "site.pp"
  end


  config.vm.provision "shell", inline: $script

end