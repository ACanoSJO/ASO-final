#!/bin/bash
cd /usr/local/bin
sudo wget "https://github.com/ACanoSJO/ASO-final/blob/main/taskManager.tar"
sudo tar -xvf taskManager.tar
alias taskManager="/usr/local/bin/taskManager/start.sh"