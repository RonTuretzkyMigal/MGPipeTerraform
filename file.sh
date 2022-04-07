#!/bin/bash

sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum -y install terraform
sudo touch ~/.bashrc
sudo terraform -install-autocomplete
sudo amazon-linux-extras install docker
sudo service docker start
sudo usermod -a -G docker ec2-user
sudo chkconfig docker on
sudo yum install -y git
sudo curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo systemctl enable docker
#sudo docker login -u ronturetzkymigal -p derpyderp2
#sudo docker pull ronturetzkymigal/mgpipe
#sudo docker run -it ronturetzkymigal/mgpipe
#sudo ./run-assembly /opt/bin/bio/SampleDir/ /home/Test1 *1.fastq.gz --verbose --ncpus=1

