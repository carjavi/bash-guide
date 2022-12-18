# bash-guide

<p align="center"><img src="https://raw.githubusercontent.com/carjavi/bash-guide/master/img/bashlogo.png" height="250" alt=" " /></p>
<br>
<h1 align="center">Bash Guide</h1> 
<h4 align="right">Aug 22</h4>

<img src="https://img.shields.io/badge/OS%20-Raspbian%20GNU%2FLinux%2011%20(bulleye)-yellowgreen">
<img src="https://img.shields.io/badge/Hardware-Raspberry%20ver%204-red">
<img src="https://img.shields.io/badge/Node%20-V18.7.0-green">
<img src="https://img.shields.io/badge/Python%20-V3.9.2-orange">


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
#sample
chmod +x setup.sh
./setup.sh

-o-

chmod 755 bash.sh
./bash.sh
```
Si quieres omitir el ./ o si quieres ejecutar el script desde cualquier directorio en el sistema de archivos debes añadir el directorio que contiene el script al path del sistema:

    export PATH=$PATH:.


##  Python into Bash
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

    #!/usr/bin/env python

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
sudo apt-get update && sudo apt-get dist-upgrade -y

# Install node libs for app
npm install serialport -g
npm install socket.io -g
npm install express -g

```


## Run JS file
```
#!/bin/sh
node OnGsm.js
```



# Install and Start Services (systemd)
```
#!/usr/bin/env bash

# Install and Start Services
cat > /etc/systemd/system/autorun.service <<EOF

  [Unit]
  Description= autorun-boot
  After=network.target

  [Service]
  ExecStart=/usr/bin/node /home/pi/autorun.js
  Restart=always
  SyslogIdentifier=node
  #User=root
  #Group=root
  Environment=NODE_ENV=production
  WorkingDirectory=/home/root

  [Install]
  WantedBy=multi-user.target

EOF

# Start deamon code
sudo systemctl daemon-reload
sudo systemctl enable autorun.service
sudo systemctl start autorun.service

# sentencias print() o mensajes de error seran capturadas por el sistema journalctl
sudo journalctl -f -u autorun
reboot  

# Another Commands:
# systemctl status autorun.service
# sudo systemctl stop autorun.service
# sudo systemctl start autorun.service
# sudo systemctl disable autorun.service
# sudo systemctl enable autorun.service

```
<a href="https://instintodigital.net/" target="_blank"><img src="https://raw.githubusercontent.com/carjavi/bash-guide/master/img/download-red.png" height="100" alt="download"></a>


## Install and Start Services -sample
```
#!/usr/bin/env bash

# Disabled UART2 for GPS
fw_setenv bootdelay 0
systemctl stop serial-getty@ttyMFD2.service
systemctl mask serial-getty@ttyMFD2.service

# Update linux system
opkg update
opkg upgrade

# Install and Start Services
cat > /etc/systemd/system/fracttal.service <<EOF

[Unit]
Description=Fracttal-OnBoard
After=network.target

[Service]
ExecStart=/usr/bin/node /home/root/app.js
Restart=always
SyslogIdentifier=node
#User=root
#Group=root
Environment=NODE_ENV=production
WorkingDirectory=/home/root

[Install]
WantedBy=multi-user.target

EOF

# Install node libs for app
npm install serialport -g
npm install bluetooth-serial-port -g
npm install sprintf-js -g
npm install mime -g

# Download source code
wget ota.fracttal.io/app.out
mv app.out app.js.gz
gzip -d app.js.gz
chmod +x app.js

# Start deamon code
systemctl daemon-reload
systemctl enable fracttal
systemctl start fracttal

systemctl disable wpa_supplicant; systemctl enable hostapd
echo -e "@xxxxxxxx**++\n@xxxxxx**++" | passwd
rm install.sh
journalctl -f -u fracttal
reboot  


#systemctl status fracttal
#test gzip -d app.min.js.gz ; mv app.min.js app.js ; systemctl restart fracttal ; journalctl -f -u fracttal
#systemctl disable wpa_supplicant; systemctl enable hostapd
#systemctl disable hostapd ; systemctl enable wpa_supplicant
#systemctl disable fracttal
#systemctl stop fracttal
#serialport-term -b 115200 -p /dev/ttyMFD
#rm Config.json; rm install.sh;rm tracker.log
#nano /etc/hostapd/hostapd.conf
```

## How download from github and run file Install.sh
```
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
```
<br>

# On RASPBERRY

verificar el espacio disponible en la SD, un 1GB minimo. Get the number of free blocks and the block size in bytes, and calculate the value in GB
```
echo "Checking for available space."
AVAILABLE_SPACE_GB=$(($(stat -f / --format="%a*%S/1024**3")))
NECESSARY_SPACE_GB=1
(( AVAILABLE_SPACE_GB < NECESSARY_SPACE_GB )) && (
    echo "Not enough free space to install blueos, at least ${NECESSARY_SPACE_GB}GB required"
    exit 1
)
```

 Check if the script is running in a supported architecture
```
SUPPORTED_ARCHITECTURES=(
  "armhf" # Pi, Pi2, Pi3, Pi4
  "armv7" # Pi2, Pi3, Pi4
  "armv7l" # Pi2, Pi3, Pi4 (Raspberry Pi OS Bullseye)
  "aarch64" # Pi3, Pi4
)
ARCHITECTURE="$(uname -m)"
[[ ! "${SUPPORTED_ARCHITECTURES[*]}" =~ $ARCHITECTURE ]] && (
    echo "Invalid architecture: $ARCHITECTURE"
    echo "Supported architectures: ${SUPPORTED_ARCHITECTURES[*]}"
    exit 1
)
```

Check if the script is running as root
```
[[ $EUID != 0 ]] && echo "Script must run as root."  && exit 1

---------

if [ "$(whoami)" != "root" ]; then
	echo "Sorry, this script must be executed with sudo or as root"
	exit 1
fi

```

<br>

## Ejemplo de como modificar un archivo de configuracion o de sistema desde un file.sh <br>
SED es una herramienta de terminal cuyo uso principal es buscar y reemplazar un texto. Podemos hacer insertar, borrar, buscar y reemplazar.
Dicho comando admite expresiones regulares que le permiten realizar una comparación de patronos complejos. Al utilizar SED, podemos editar archivos, incluso sin abrirlos, de manera individual o masiva. busque "Uso del comando Sed en Linux" para mas información.
```
echo "Disabling automatic Link-local configuration in dhcpd.conf."
# delete line if it already exists
sed -i '/noipv4ll/d' /etc/dhcpcd.conf
# add noipv4ll
sed -i '$ a noipv4ll' /etc/dhcpcd.conf

-----------

# add docker entry to rc.local
sed -i "\%^exit 0%idocker start blueos-bootstrap" /etc/rc.local || echo "sed failed to add expand_fs entry in /etc/rc.local"

----------

# insert S1 above the first uncommented exit 0 line in the file
sudo sed -i -e "\%$S1%d" \
-e "0,/^[^#]*exit 0/s%%$S1\n&%" \
/etc/rc.local

----------

# Enable RPi camera interface
sudo sed -i '\%start_x=%d' /boot/config.txt
sudo sed -i '\%gpu_mem=%d' /boot/config.txt
sudo sed -i '$a start_x=1' /boot/config.txt
sudo sed -i '$a gpu_mem=128' /boot/config.txt
```

## conteo regresivo para reiniciar
```
echo "System will reboot in 10 seconds."
sleep 10 && reboot
```

<br>

# Samples

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
#!/bin/bash
cd /home/pi/max/node-ads1x15-master
sudo node fir5.js
```

```
#!/usr/bin/env bash
ExecStart=node /home/pi/maquintel/node-ads1x15-master/fir5.js
```

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




```
#!/bin/bash

# Gphoto2 compiler and installer script
#
# This script is specifically created for Raspbian http://www.raspbian.org
# and Raspberry Pi http://www.raspberrypi.org but should work over any
# Debian-based distribution

# Created and mantained by Gonzalo Cao Cabeza de Vaca
# Please send any feedback or comments to gonzalo.cao(at)gmail.com
# Updated for gPhoto2 2.5.1.1 by Peter Hinson
# Updated for gPhoto2 2.5.2 by Dmitri Popov
# Updated for gphoto2 2.5.5 by Mihai Doarna
# Updated for gphoto2 2.5.6 by Mathias Peter
# Updated for gphoto2 2.5.7 by Sijawusz Pur Rahnama
# Updated for gphoto2 2.5.8 by scribblemaniac
# Updated for gphoto2 2.5.9 at GitHub by Gonzalo Cao
# Updated for last development release at GitHub by Gonzalo Cao
# Updated for gphoto2 2.5.10 by Gonzalo Cao

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

latest_stable_libgphoto_version=2_5_19
latest_stable_gphoto_version=2_5_17
display_version=$(echo "libgphoto ${latest_stable_libgphoto_version}; gphoto ${latest_stable_gphoto_version}" | tr '_' '.')
branch_libgphoto=''
branch_gphoto=''
cores=$(nproc)

if [ "$(whoami)" != "root" ]; then
	echo "Sorry, this script must be executed with sudo or as root"
	exit 1
fi

usage()
{
cat << EOF
usage: sudo $0 [-h|--help|-s|--stable|-d|--development]
-h|--help: this help message
-s|--stable: select the stable version: ${display_version}
-d|--development: select the latest develoment version
Note: An interactive menu is displayed if no parameter is given.
EOF
exit 1
}

parse_options()
{
if ! all_options=$(getopt -o hds -l help,development,stable -- "$@")
then
    usage
fi
eval set -- "$all_options"

while true
do
    case "$1" in
        -h|--help)          usage;;
        -d|--development)   shift 1;;
        -s|--stable)        branch_libgphoto="--branch libgphoto2-${latest_stable_libgphoto_version}-release"
                            branch_gphoto="--branch gphoto2-${latest_stable_gphoto_version}-release"
                            shift 1;;
        --)                 break ;;
    esac
done
}

menu()
{
PS3='Please enter your choice: '
options=("Install last development version"
         "Install last stable release (${display_version})"
				 "Quit")

select opt in "${options[@]}"
do
    case $opt in
        "Install last development version")
						echo
            echo "\"Install last development version\" selected"
						echo
						break
            ;;
        "Install last stable release (${display_version})")
						echo
            echo "\"Install last stable release (${display_version})\" selected"
						echo
						branch_libgphoto="--branch libgphoto2-${latest_stable_libgphoto_version}-release"
						branch_gphoto="--branch gphoto2-${latest_stable_gphoto_version}-release"
						break
            ;;
        "Quit")
            exit 0
            ;;
        *) echo invalid option;;
    esac
done
}

# Display the menu if the script was called without any parameters
# else try to parse the options
if [ $# -eq 0 ]
then
    menu
else
    parse_options "$@"
fi

echo
echo "----------------"
echo "Updating sources"
echo "----------------"
echo

apt-get update -qq

echo
echo "-----------------------------------------"
echo "Removing gphoto2 and libgphoto2 if exists"
echo "-----------------------------------------"
echo

apt-get remove -y gphoto2 libgphoto2*

echo
echo "-----------------------"
echo "Installing dependencies"
echo "-----------------------"
echo

apt-get install -y build-essential libltdl-dev libusb-1-dev libexif-dev libpopt-dev libudev-dev pkg-config git automake autoconf autopoint gettext libtool wget

echo
echo "-------------------------"
echo "Creating temporary folder"
echo "-------------------------"
echo

mkdir gphoto2-temp-folder
cd gphoto2-temp-folder

echo "gphoto2-temp-folder created"


echo
echo "----------------------"
echo "Downloading libgphoto2"
echo "----------------------"
echo

if (/usr/bin/git clone $branch_libgphoto https://github.com/gphoto/libgphoto2.git)
    then
        cd libgphoto2/
	else
		echo "Unable to get libgphoto2"
		echo "Exiting..."
		exit 1
fi


echo
echo "-----------------------------------"
echo "Compiling and installing libgphoto2"
echo "-----------------------------------"
echo

autoreconf --install --symlink
./configure
make -j "$cores"
make install
cd ..

echo
echo "-------------------"
echo "Downloading gphoto2"
echo "-------------------"
echo

if (/usr/bin/git clone  $branch_gphoto https://github.com/gphoto/gphoto2.git)
  then
        cd gphoto2
	else
		echo "Unable to get gphoto2"
		echo "Exiting..."
		exit 1
fi


echo
echo "--------------------------------"
echo "Compiling and installing gphoto2"
echo "--------------------------------"
echo

autoreconf --install --symlink
./configure
make -j "$cores"
make install
cd ..

echo
echo "-----------------"
echo "Linking libraries"
echo "-----------------"
echo

ldconfig

echo
echo "---------------------------------------------------------------------------------"
echo "Generating udev rules, see http://www.gphoto.org/doc/manual/permissions-usb.html"
echo "---------------------------------------------------------------------------------"
echo

udev_version=$(udevadm --version)

if   [ "$udev_version" -ge "201" ]
then
  udev_rules=201
elif [ "$udev_version" -ge "175" ]
then
  udev_rules=175
elif [ "$udev_version" -ge "136" ]
then
  udev_rules=136
else
  udev_rules=0.98
fi

/usr/local/lib/libgphoto2/print-camera-list udev-rules version $udev_rules group plugdev mode 0660 > /etc/udev/rules.d/90-libgphoto2.rules

if   [ "$udev_rules" = "201" ]
then
  echo
  echo "------------------------------------------------------------------------"
  echo "Generating hwdb file in /etc/udev/hwdb.d/20-gphoto.hwdb. Ignore the NOTE"
  echo "------------------------------------------------------------------------"
  echo
  /usr/local/lib/libgphoto2/print-camera-list hwdb > /etc/udev/hwdb.d/20-gphoto.hwdb
fi


echo
echo "-------------------"
echo "Removing temp files"
echo "-------------------"
echo

cd ..
rm -r gphoto2-temp-folder



echo
echo "--------------------"
echo "Finished!! Enjoy it!"
echo "--------------------"
echo

gphoto2 --version
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


---
Copyright &copy; 2022 [carjavi](https://github.com/carjavi). <br>
```www.instintodigital.net``` <br>
carjavi@hotmail.com <br>
<p align="center">
    <a href="https://instintodigital.net/" target="_blank"><img src="https://raw.githubusercontent.com/carjavi/bash-guide/master/img/developer.png" height="100" alt="www.instintodigital.net"></a>
</p>

