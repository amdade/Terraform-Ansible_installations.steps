#!/bin/sh

# Install Ansible repository.
apt -y update && apt-get -y upgrade
apt-get install software-properties-common
apt-add-repository ppa:ansible/ansible -y

apt-get -qq install python -y

# Install Ansible.
apt-get update
apt-get install ansible -y

# Installing unzip
apt-get install unzip -y 

# Installing AWS
apt-get install awscli -y

# Installing graphviz
apt-get install graphviz -y

# Installing python3 and python3-pip
#apt-get install -y  python3 python3-pip 

#pip3 install --upgrade setuptools
#pip3 install BlastRadius

# Installing boto and botocore
#pip3 install boto3
#pip3 install botocore

# Installing git
apt-get install git -y

# Cleanup unneded packages
apt-get -y autoremove

# Adjust timezone to be Singapore
ln -sf /usr/share/zoneinfo/Asia/Singapore /etc/localtime

# add user to sudo groups
usermod -aG sudo vagrant

# lsb_release -a

# Add vagrant user to sudoers.
echo "vagrant        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers
sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers

# Disable daily apt unattended updates.
#echo 'APT::Periodic::Enable "0";' >> /etc/apt/apt.conf.d/10periodic

# generating password configuration on ansible server to later access remote servers
echo vagrant | sudo -S su - vagrant -c "ssh-keygen -t rsa -f /home/vagrant/.ssh/id_rsa -q -P ''"
#ssh-keygen -f ~/keypair -P ""
#ssh-keygen -t rsa -f /home/vagrant/.ssh/id_rsa -q -P ''


#echo vagrant | sudo -S su - vagrant -c "ssh-keygen -t rsa -b 2048 -f ~/.ssh/MyKeyPair.pem -q -P ''"
#sudo chmod 400 ~/.ssh/MyKeyPair.pem
#echo vagrant | sudo -S su - vagrant -c "ssh-keygen -y -f ~/.ssh/MyKeyPair.pem | tee -a ~/.ssh/MyKeyPair.pub"


#ssh-keygen -t rsa -b 4096 -f ~/.ssh/MyKeyPair.pem -C 'My web-server key' -q -P ''
#ssh-copy-id -i $HOME/.ssh/id_rsa.pub user@server1.cyberciti.biz




##########################################################################################################################################################

#!/bin/sh

# add addresses to /etc/hosts
echo "192.168.99.160 terraform.sample.com" | sudo tee -a /etc/hosts

TERRAFORM_VERSION="0.11.11"
WORKDIR=/tmp/terraform
mkdir -p "$WORKDIR"
cd "$WORKDIR"

# Install Terraform
curl -f "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" -o "terraform_${TERRAFORM_VERSION}_linux_amd64.zip"
sudo unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/local/bin/
sudo chmod +x  /usr/local/bin/terraform

# https://github.com/adammck/terraform-inventory
# Install terraform-inventory
wget https://github.com/adammck/terraform-inventory/releases/download/v0.8/terraform-inventory_v0.8_linux_amd64.zip
sudo unzip terraform-inventory_v0.8_linux_amd64.zip -d /usr/local/bin/
sudo chmod +x  /usr/local/bin/terraform-inventory

# https://www.cyberciti.biz/faq/how-to-set-up-ssh-keys-on-linux-unix/
#ssh-keygen -t rsa -b 4096 -f ~/.ssh/vps-cloud.web-server.key -C "My web-server key"
cd ~
rm -rf "$WORKDIR"

