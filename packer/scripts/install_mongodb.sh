#! /bin/bash
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
sudo apt update -y
sudo apt install -y mongodb-org
sudo mv /tmp/mongodb.service /etc/systemd/system/mongodb.service
sudo systemctl start mongodb
sudo systemctl enable mongodb
