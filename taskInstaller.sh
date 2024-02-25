#!/bin/bash
cd /usr/local/bin
sudo wget "https://github.com/ACanoSJO/ASO-final/raw/main/taskManager.zip"
sudo apt install zip unzip
sudo unzip taskManager.zip
sudo alias taskManager="sudo sh /usr/local/bin/taskManager/start.sh"
sudo chmod -R +x /usr/local/bin/taskManager
sudo rm /usr/local/bin/taskManager.zip