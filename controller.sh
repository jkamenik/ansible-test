#!/bin/bash

PATH=/usr/bin:/bin:/usr/sbin:/sbin
DEBIAN_FRONTEND=noninteractive

set -x

sudo bash -c 'echo LC_ALL="en_US.UTF-8" >> /etc/default/locale'

sudo apt-get -y autoremove
sudo apt-get -q update
sudo apt-get -y upgrade
sudo apt-get -y install build-essential wget curl git-core ntp \
     python-pip

sudo pip install paramiko PyYAML Jinja2 httplib2 six

# do cool stuff here
if [ ! -d /vagrant/ansible ]; then
  echo "Cloning ansible"
  (cd /vagrant &&
   git clone http://github.com/ansible/ansible.git --recursive)
fi

sudo chown -R vagrant:vagrant /home/vagrant

# cleanup
sudo apt-get -y autoremove
