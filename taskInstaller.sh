#!/bin/bash
cd /usr/local/bin
wget "https://github.com/ACanoSJO/ASO-final/blob/main/taskManager.tar"
tar -xvf taskManager.tar
alias taskManager="/usr/local/bin/taskManager/start.sh"