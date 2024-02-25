#!/bin/bash
cd /usr/local/bin
sudo wget "https://github.com/ACanoSJO/ASO-final/blob/main/taskManager.zip"
sudo apt install unzip
sudo unzip taskManager.zip
alias taskManager="/usr/local/bin/taskManager/start.sh"