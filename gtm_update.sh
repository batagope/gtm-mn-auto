#!/bin/bash

COIN='GTM'
COIN_TGZ='https://github.com/genterium-project/gentarium/releases/download/v1.2.0/ge-linux64.tar.gz'
COIN_ZIP=$(echo $COIN_TGZ | awk -F'/' '{print $NF}')
COIN_PATH='/usr/local/bin/'
COIN_DAEMON='gentariumd'
COIN_CLI='gentarium-cli'
TEMP_BIN='/root/ge/bin'

# get the zipped file from the gentarium github repository
echo -e "Downloading new $COIN wallet......."
wget -q $COIN_TGZ && echo "Finished"
#unzip the file
echo -e "Unzipping the new $COIN wallet....."
tar xvzf $COIN_ZIP >/dev/null 2>&1 && echo "Finished"
#make gentarium-cli wallet and gentariumd deamon executable
cd $TEMP_BIN && chmod +x $COIN_DAEMON $COIN_CLI && cd
#stop the gentarium deamon
echo -e "Stopping the $COIN deamon.........."
systemctl stop $COIN.service && echo "Stopped"
#remove old gentarium-cli wallet and gentariumd deamon from the system and return back to root folder
echo -e "Remove old, and install new $COIN wallet files....."
cd $COINPATH && sudo rm $COIN_CLI $COIN_DAEMON && cd
#copy new gentarium-cli wallet and gentariumd deamon to the system
cd $TEMP_BIN && cp $COIN_DAEMON $COIN_CLI $COIN_PATH && cd
#remove unzipped folder
echo -e "Removing unnecessary files........."
rm -rf ge
#remove zipped folder
rm $COIN_ZIP
#start new gentariumd daemon
echo -e "Starting new $COIN deamon.........."
systemctl start $COIN.service && echo "Started"






