#!/bin/bash
# This script assumes that the data are still in google drive.
# At first, it downloads the csv file into the current folder, then it performs all the other steps as specified in the task requirements.
# If you don't have enough space on your disk, don't let the script run for a long period of time since.
# After bruptly interompting it, run command: rm data.csv | rm -r /downloadedData/
tempFile='data.csv'
wget --load-cookies cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1EfRc2RLVdwWlXWz3nDIBEv_EvvOMd9ip' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1EfRc2RLVdwWlXWz3nDIBEv_EvvOMd9ip" -p 5 -O ${tempFile} && rm -rf cookies.txt
columnIndex= $(head -1 ${tempFile} | tr ';' '\n' | nl |grep -w ${COLUMN_NAME} | tr -d " " | awk -F " " '{print $1}')
awk -F "\"*;\"*" "{print \$${columnIndex}}" $tempFile | parallel -j ${NR_THREAD} --progress wget -q {} -P ${OUTPUT_FOLDER}