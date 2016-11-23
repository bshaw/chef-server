#set hostname
sudo hostname chef.vbox.local
sudo sed -i '/HOSTNAME=/c\HOSTNAME=chef.vbox.local' /etc/sysconfig/network
sudo echo -e "127.0.0.1 `hostname` `hostname -s`" | sudo tee -a /etc/hosts
sudo /etc/init.d/network restart

#install deps
sudo yum -y install git curl wget tar vim

#update
sudo yum -y update

#install chef-solo
curl -L https://www.chef.io/chef/install.sh | sudo bash

#create required bootstrap dirs/files
sudo mkdir -p /var/chef/cache /var/chef/cookbooks

#pull down chef-server cookbook
wget -qO- https://supermarket.chef.io/cookbooks/chef-server/download | sudo tar xvzC /var/chef/cookbooks

#pull down dependency cookbooks
wget -qO- https://supermarket.chef.io/cookbooks/chef-server-ingredient/download | sudo tar xvzC /var/chef/cookbooks
wget -qO- https://supermarket.chef.io/cookbooks/chef-ingredient/download | sudo tar xvzC /var/chef/cookbooks
wget -qO- https://supermarket.chef.io/cookbooks/packagecloud/download | sudo tar xvzC /var/chef/cookbooks
wget -qO- https://supermarket.chef.io/cookbooks/apt/download | sudo tar xvzC /var/chef/cookbooks
wget -qO- https://supermarket.chef.io/cookbooks/apt-chef/download | sudo tar xvzC /var/chef/cookbooks
wget -qO- https://supermarket.chef.io/cookbooks/yum/download | sudo tar xvzC /var/chef/cookbooks
wget -qO- https://supermarket.chef.io/cookbooks/yum-chef/download | sudo tar xvzC /var/chef/cookbooks
wget -qO- https://supermarket.chef.io/cookbooks/compat_resource/download | sudo tar xvzC /var/chef/cookbooks

#install chef-server
sudo chef-solo -o 'recipe[chef-server::default]'

#create an admin user
sudo chef-server-ctl user-create --filename admin.pem admin Chef Admin dev@null.com Password1!

#create an organization
sudo chef-server-ctl org-create vagrant "Vagrant" --association_user admin --filename vagrant.pem

#setup chef server as a client of its self
sudo cp vagrant.pem /etc/chef/validation.pem
knife ssl fetch
sudo cp -R /root/.chef/trusted_certs/ /etc/chef/

#copy keys to host
cp admin.pem /vagrant/.chef/
cp vagrant.pem /vagrant/.chef/
