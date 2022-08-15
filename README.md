# bash-guide

<p align="center"><img src="https://raw.githubusercontent.com/carjavi/bash-guide/master/img/bashlogo.png" height="100" alt=" " /></p>
<br>
<h1 align="center">Bash Guide</h1> 
<h4 align="right">Aug 22</h4>

<img src="https://img.shields.io/badge/OS%20-Raspbian%20GNU%2FLinux%2011%20(bulleye)-yellowgreen">
<img src="https://img.shields.io/badge/Hardware-Raspberry%20ver%204-red">
<img src="https://img.shields.io/badge/Node%20-V18.7.0-green">
<img src="https://img.shields.io/badge/Python%20-V3.9.2-orange">

<br>

## Run file bash file
```
bash [options] [file]
bash file.sh

Options:
-i  the shell is interactive

Arguments:
--verbose  Equivalent to -v.
--help   Display a usage message and exit.
```
## To do autorun bash file
```
chmod 755 donde-estoy.sh
./bash.sh
```
Si quieres omitir el ./ o si quieres ejecutar el script desde cualquier directorio en el sistema de archivos debes añadir el directorio que contiene el script al path del sistema:

    export PATH=$PATH:.

## INCRUSTAR PYTHON EN BASH
```
#!/bin/bash

python3 -c "

i = 0
while i < 10:
    print(i, end=' ')
    i += 1
"
```
El resultado es el siguiente: 0 1 2 3 4 5 6 7 8 9

## Python y Bash
```
#!/bin/bash

function main { python -c "

import time
import datetime

for i in range(100):
    with open('log.txt', 'a') as f:
        f.write(str(datetime.datetime.now())+'\n')

"; }

main &
```

## Print Screen
```
myvar="This is the value of my variable."
echo $myvar

myvar="12";echo $(( $myvar + 3 ))
#print 15


```

## Run bash file from Python 
```
import subprocess
exit_code = subprocess.call('./practice.sh')
print(exit_code)

##file bash

#!/bin/bash
echo "Hello, World!"
exit 1
```

## Upgrade & Install 
```
#!/usr/bin/env bash

# Update linux system
opkg update
opkg upgrade

# Install node libs for app
npm install upgrade
#npm install update
npm install serialport -g
npm install socket.io -g
npm install express -g
npm install mraa -g
```
## Tipical Setup.sh
```
#!/bin/bash

# RPi2 setup script for use as companion computer. This script is simplified for use with
# the ArduSub code.
cd /home/pi

# Update package lists and current packages
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -yq

# Update Raspberry Pi
sudo DEBIAN_FRONTEND=noninteractive apt-get install -yq rpi-update
sudo rpi-update -y

# install python and pip
sudo apt-get install -y python-dev python-pip python-libxml2

# dependencies
sudo apt-get install -y libxml2-dev libxslt1-dev

sudo pip install future

# install git
sudo apt-get install -y git

# download and install pymavlink from source in order to have up to date ArduSub support
git clone https://github.com/mavlink/mavlink.git /home/pi/mavlink

pushd mavlink
git submodule init && git submodule update --recursive
pushd pymavlink
sudo python setup.py build install
popd
popd

# install MAVLink tools
sudo pip install mavproxy dronekit dronekit-sitl # also installs pymavlink

# install screen
sudo apt-get install -y screen

# web ui dependencies, separate steps to avoid conflicts
sudo apt-get install -y node
sudo apt-get install -y nodejs-legacy
sudo apt-get install -y npm

# node updater
sudo npm install n -g

# Get recent version of node
sudo n 5.6.0

# browser based terminal
sudo npm install tty.js -g

# clone bluerobotics companion repository
git clone https://github.com/bluerobotics/companion.git /home/pi/companion

cd $HOME/companion/br-webui

npm install

# Disable camera LED
sudo sed -i '\%disable_camera_led=1%d' /boot/config.txt
sudo sed -i '$a disable_camera_led=1' /boot/config.txt

# Enable RPi camera interface
sudo sed -i '\%start_x=%d' /boot/config.txt
sudo sed -i '\%gpu_mem=%d' /boot/config.txt
sudo sed -i '$a start_x=1' /boot/config.txt
sudo sed -i '$a gpu_mem=128' /boot/config.txt

# source startup script
S1=". $HOME/companion/.companion.rc"

# this will produce desired result if this script has been run already,
# and commands are already in place
# delete S1 if it already exists
# insert S1 above the first uncommented exit 0 line in the file
sudo sed -i -e "\%$S1%d" \
-e "0,/^[^#]*exit 0/s%%$S1\n&%" \
/etc/rc.local

# compile and install gstreamer 1.8 from source
if [ "$1" = "gst" ]; then
    $HOME/companion/scripts/setup_gst.sh
fi

sudo reboot now
```

## Run JS file
```
#!/bin/sh
node OnGsm.js
```

## Run commands console
```
#! /bin/bash

# Configuracion para el Intel NUC
#wlp2s0 es la tarjeta de RED la configurcion de la red y password esta en Wireless.conf

ifconfig wlp2s0 down
dhclient wlp2s0 -r
ifconfig wlp2s0 up
iwconfig wlp2s0 mode Managed
killall wpa_supplicant
wpa_supplicant -B -Dwext -i wlp2s0 -c ./wireless-wpa.conf -dd
dhclient wlp2s0
```
```
#! / bin / bash 

echo "Lectura de Sensores a Fracttal... "
#node ~/fracttal/DemoFracttal/DemoMarsol.js
#cd  ~/fracttal/DemoFracttal/
#cd /fracttal/DemoFracttal/
#./node DemoMarsol.js
#node DemoMarsol.js
node /root/fracttal/DemoFracttal/DemoMarsol.js
#node ./name.js
```

## How download from github and run file Install.sh
```
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
```

## Samples
```
#!/bin/bash

reldir=`dirname $0`
cd $reldir
directory=`pwd`

echo "Directory is $directory"

echo "This script is about to run another script."
sh ./script.sh
echo "This script has just run another script."

sh <path to script>/script.sh

( exec "path/to/script" )
```
```
#!/bin/bash
$SCRIPT_PATH="/path/to/script.sh"

# Here you execute your script
"$SCRIPT_PATH"

# or
. "$SCRIPT_PATH"
# or
source "$SCRIPT_PATH"
# or
bash "$SCRIPT_PATH"
# or
eval '"$SCRIPT_PATH"'
# or
OUTPUT=$("$SCRIPT_PATH")
echo $OUTPUT
# or
OUTPUT=`"$SCRIPT_PATH"`
echo $OUTPUT
# or
("$SCRIPT_PATH")
# or
(exec "$SCRIPT_PATH")
```



---
Copyright &copy; 2022 [carjavi](https://github.com/carjavi). <br>
```www.instintodigital.net``` <br>
carjavi@hotmail.com <br>
<p align="center">
    <a href="https://instintodigital.net/" target="_blank"><img src="https://raw.githubusercontent.com/carjavi/bash-guide/master/img/developer.png" height="100" alt="www.instintodigital.net"></a>
</p>

