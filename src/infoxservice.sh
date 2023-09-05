#!/bin/sh
LOGTIME=`date +%s%N`;
echo "----------------------------------------------------------\ncore scripts start.\ntime: ${LOGTIME}\n----------------------------------------------------------";
echo "----------------------------------------------------------\ncore scripts start.\ntime: ${LOGTIME}\n----------------------------------------------------------" >> log/log.log;
sh ./core/core_1.sh & sh ./core/core_2.sh & sh ./core/core_3.sh & sh ./core/core_4.sh;