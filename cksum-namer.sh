#!/bin/bash

ls *.pdf | while read i 
do 
NAME=`echo "$i"| sed 's/.pdf//'`
CKSUM=`find '/PATH/TO/ROMS' -name "$NAME".nes.trim -exec crc32 {} \; -quit` 
PDFCKSUM="$NAME [$CKSUM].pdf"
mv -v "$i" "$PDFCKSUM"
done
