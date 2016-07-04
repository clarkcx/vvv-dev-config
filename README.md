# vvv-dev-config
Config instructions to set up Vagrant, VirtualBox and VVV for local Wordpress Dev

# Install Vagrant, VirtualBox and plugins

- [Install vagrant](https://www.vagrantup.com/downloads.html)
- [Install VirtualBox](https://www.virtualbox.org/wiki/Downloads)

## Install Vagrant Plugins (if not already done)

	$ vagrant plugin install vagrant-hostsupdater
	$ vagrant plugin install vagrant-triggers

## Clone VVV to a project folder

	$ cd ~/Sites/
	$ git clone https://github.com/Varying-Vagrant-Vagrants/VVV.git ~/Sites/vagrant-local
	$ cd ~/Sites/vagrant-local

## Set up vvv-init.sh script 

	$ cp vvv-init.sh ~/Sites/vagrant-local/www
	$ nano vvv-init.sh

Set DEVSITE and EMAIL variables and save the file.

## Run Vagrant

	$ vagrant up

The above command takes aaaaagggeeesss to run. Like 30 minutes or more. 

	$ vagrant reload

The above command is required to get the add the URL to the hosts file

## Adding additional dev sites

Make changes to vvv-init.sh and run the following commmands

	$ vagrant provision
	$ vagrant reload

## Loging in to Wordpress

- local.whateverthesiteis.dev/wp-login.php
- admin
- password

## Loging into the Virtual Server

	$ vagrant ssh
