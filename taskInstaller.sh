#!/bin/bash
cd /usr/local/bin
curl -JLO "https://github.com/ACanoSJO/proyecto-ASO-task-manager/taskManager.zip"
unzip taskManager.zip
alias taskManager="/usr/local/bin/taskManager/start.sh"