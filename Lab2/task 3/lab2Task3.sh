#!/bin/bash
find ${FOLDER} -type f | head -n ${NR_OF_FILES} | parallel -j ${NR_THREAD} --progress egrep -I -i -o '[[:digit:]]+' {} | awk '{s+=$1/NR} END {print s}'