#!/bin/bash
apt update 
apt install wget unzip apache2 -y
systemctl start apache2
systemctl enable apache2
wget https://www.tooplate.com/download/2140_stellaris_research/2140_stellaris_research.zip
unzip -o 2140_stellaris_research.zip
cp -r 2140_stellaris_research/* /var/www/html/
systemctl restart apache2