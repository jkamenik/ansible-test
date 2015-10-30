#!/bin/bash

PATH=/usr/bin:/bin:/usr/sbin:/sbin
DEBIAN_FRONTEND=noninteractive
BASE_PATH=/vagrant/controller
ANSIBLE_PATH=$BASE_PATH/ansible
DEST_PATH=/home/vagrant

set -x

sudo bash -c 'echo LC_ALL="en_US.UTF-8" >> /etc/default/locale'

sudo apt-get -y autoremove
sudo apt-get -q update
sudo apt-get -y upgrade
sudo apt-get -y install build-essential wget curl git-core ntp \
     sshpass python-pip

sudo pip install paramiko PyYAML Jinja2 httplib2 six

# install ansible if it doesn't exit
if [ ! -d $ANSIBLE_PATH ]; then
  echo "Cloning ansible"
  (cd $BASE_PATH &&
   git clone http://github.com/ansible/ansible.git --recursive)
fi

rm $DEST_PATH/ansible
ln -s $ANSIBLE_PATH $DEST_PATH/ansible

# move files
function move(){
  local file=$BASE_PATH/$1
  local dest=$DEST_PATH

  if [ -n "$2" ]; then
    dest="$dest/$2/$1"
  else
    dest="$dest/$1"
  fi

  echo "moving $file to $dest"
  cp $file $dest

  if [ -n "$3" ]; then
    chmod $3 $dest
  fi
}
function link(){
  local file=$BASE_PATH/$1
  local dest=$DEST_PATH

  if [ -n "$2" ]; then
    dest="$dest/$2/$1"
  else
    dest="$dest/$1"
  fi

  echo "linking $file to $dest"
  rm $dest
  ln -s $file $dest
}
move .bashrc
move id_rsa .ssh 600
move id_rsa.pub .ssh 600
link .bash_ansible
link ansible_hosts
link slave.yml

# fix permissions
sudo chown -R vagrant:vagrant /home/vagrant

# cleanup
sudo apt-get -y autoremove
