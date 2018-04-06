#! /bin/bash
sudo apt update -y
sudo apt install -y python-software-properties curl unzip git
# Install php
sudo add-apt-repository -y ppa:ondrej/php
sudo apt update -y
sudo apt install -y php7.2-common php7.2-cli php7.2-curl php7.2-json php7.2-mbstring php7.2-xml php7.2-zip
# Install composer
curl -sS https://getcomposer.org/installer -o composer-setup.php
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
sudo composer global require hirak/prestissimo
sudo chown $(whoami):$(whoami) .composer/ -R
sudo rm composer-setup.php
