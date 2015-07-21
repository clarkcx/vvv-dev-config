# vvv-dev-config
Config instructions to set up Vagrant, VirtualBox and VVV for local Wordpress Dev

# Install Vagrant, VirtualBox and plugins

Install vagrant
Install VirtualBox

## Install Vagrant Plugins (if not already done)

$ vagrant plugin install vagrant-hostsupdater
$ vagrant plugin install vagrant-triggers

## Clone VVV to a project folder

$ cd ~/Sites/
$ git clone https://github.com/Varying-Vagrant-Vagrants/VVV.git vagrant-local
$ cd ~/Sites/vagrant-local

## Set up vvv-init.sh script 

$ cp vvv-init.sh ~/Sites/vagrant-local/www
$ nano vvv-init.sh

Set DEVSITE and EMAIL variables and save the file.

## Run Vagrant

$ vagrant up

The above command takes aaaaagggeeesss to run. Like 20 minutes or more. 

## Adding additional dev sites

Make changes to vvv-init.sh and run the following commmands

$ vagrant provision
$ vagrant reload
