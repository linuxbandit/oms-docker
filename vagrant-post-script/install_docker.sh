#!/bin/bash

#taken from https://docs.docker.com/engine/installation/linux/ubuntulinux/

echo "Installing docker from script file"

sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" | sudo tee /etc/apt/sources.list.d/docker.list
sudo apt-get update
sudo apt-get install -y linux-image-extra-$(uname -r) linux-image-extra-virtual
sudo apt-get install -y docker-engine
#sudo service docker start
curl -L https://github.com/docker/compose/releases/download/1.9.0/docker-compose-`uname -s`-`uname -m` > ~/docker-compose
sudo mv ~/docker-compose /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

sudo apt-get install -y git vim

#checking if the repo has been cloned or downloaded through zip 
if [ ! -f /home/vagrant/oms-docker/oms-core/composer.json ]; then
    git clone -b dev --recursive https://github.com/AEGEE/oms-docker.git fixme
    rsync --remove-source-files -av fixme/ oms-docker/
    rm -rf fixme
fi

echo "now installation as per the instruction of the readme"
#soon it will be orchestrated by vagrant

cd oms-docker/docker
docker-compose up -d
docker-compose exec omscore bash /root/bootstrap.sh