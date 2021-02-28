#!/bin/bash
sudo apt update -y
sudo apt upgrade -y
OSVERSION=`lsb_release -d`

if [ ! -d ~/raptoreum ]; then
	mkdir raptoreum
fi

if [[ $OSVERSION == *"20.04"* ]]; then
	#Ubuntu 20
	wget https://github.com/Raptor3um/raptoreum/releases/download/1.1.15.1/raptoreum_1.1.15.1_ubuntu_20_64.tar.gz
	mv raptoreum_1.1.15.1_ubuntu_20_64.tar.gz ~/raptoreum
	echo "taring"
	tar -xvf ~/raptoreum/raptoreum_1.1.15.1_ubuntu_20_64.tar.gz -C ~/raptoreum
	rm ~/raptoreum/raptoreum_1.1.15.1_ubuntu_20_64.tar.gz
	
else
	#Ubuntu 18
	wget https://github.com/Raptor3um/raptoreum/releases/download/1.1.15.1/raptoreum_1.1.15.1_ubuntu18_64.tar.gz
	mv raptoreum_1.1.15.1_ubuntu18_64.tar.gz ~/raptoreum
	echo "taring"
	tar -xvf ~/raptoreum/raptoreum_1.1.15.1_ubuntu18_64.tar.gz -C ~/raptoreum
	rm ~/raptoreum/raptoreum_1.1.15.1_ubuntu18_64.tar.gz
fi

randomusername=`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 12 | head -n 1`
randompasswd=`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 12 | head -n 1`

if [ ! -d ~/.raptoreumcore ]; then
	mkdir ~/.raptoreumcore
fi

if [ ! -f ~/.raptoreumcore/raptoreum.conf ]; then
	touch ~/.raptoreumcore/raptoreum.conf
fi

 echo '
rpcuser='"${randomusername}"'
rpcpassword='"${randompasswd}"'
rpcallowip=127.0.0.1
rpcport=8777
daemon=1
listen=1
' | sudo -E tee ~/.raptoreumcore/raptoreum.conf >/dev/null 2>&1
      sudo chmod 0600 ~/.raptoreumcore/raptoreum.conf
	  
./raptoreum/raptoreumd
