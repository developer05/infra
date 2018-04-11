#!/bin/bash
set -e

source ~/.profile
git clone https://github.com/developer05/skeleton4.git
cd skeleton4
composer install

sudo mv /tmp/catalog.service /etc/systemd/system/catalog.service
sudo systemctl start catalog
sudo systemctl enable catalog
