# chef-server
Installs Chef Server on Centos.

## Setup
### Add the Vagrant box
```
vagrant box add bento/centos-6.8 --provider virtualbox
```

### Add the fqdn of the chef-server VM to the host's hosts file
```
sudo echo -e "192.168.33.10 chef.vbox.local" | sudo tee -a /etc/hosts
```

## Run / install
```
vagrant up
```
