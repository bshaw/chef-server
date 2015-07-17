# chef-server
Installs Chef Server.

## Setup
Add the fqdn of the chef-server VM to the host's hosts file
```
sudo echo -e "192.168.33.10 chef.vbox.local" | sudo tee -a /etc/hosts
```

## Run / install
```
vagrant up
```
