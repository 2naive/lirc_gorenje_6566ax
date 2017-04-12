sudo apt-get -y install lirc
sudo echo "
lirc_dev
lirc_rpi gpio_in_pin=23 gpio_out_pin=22
" >> /etc/modules
sudo echo "
LIRCD_ARGS=--uinput
LOAD_MODULES=true
DRIVER=default
DEVICE=/dev/lirc0
MODULES=lirc_rpi
" > /etc/lirc/hardware.conf
sudo echo "dtoverlay=lirc-rpi,gpio_in_pin=23,gpio_out_pin=22" >> /boot/config.txt
sudo wget -O /etc/lirc/lircd.conf https://raw.githubusercontent.com/2naive/lirc_gorenje_6566ax/master/lircd.conf
sudo apt-get-y install nodejs
sudo ln -s /usr/bin/nodejs /usr/bin/node
sudo apt-get -y install npm
sudo npm install -g lirc_web
sudo wget -O /root/.lirc_web_config.json https://raw.githubusercontent.com/2naive/lirc_gorenje_6566ax/master/.lirc_web_config.json
crontab -l | { cat; echo "@reboot sudo /usr/bin/node /usr/local/lib/node_modules/lirc_web/app.js &"; } | crontab -
reboot
