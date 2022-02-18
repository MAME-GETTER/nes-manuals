PDFDIR='/PATH/TO/PDFS'
MISDIR='/media/fat/docs/nes/manuals'
DLPATH='https://archive.org/download/nes-manuals-no-header-help-screen/'


echo "{
    "db_id": "nes-manuals-no-header-help-screen-usa_db",
    "default_options": {},
    "files": {"


cd "$PDFDIR"

ls *.pdf | while read i 
do 
URL=`echo ""$DLPATH"$(python3 -c "import urllib.parse; print(urllib.parse.quote('''$i'''))")"`
MD5SUM=`md5sum "$i" | awk '{print$1}'`
SIZE=`stat --format="%s" "$i"`

	echo "        \""$MISDIR/$i"\": {"
	echo "            \"hash\": \"$MD5SUM\","
	echo "            \"overwrite\": false,"
	echo "            \"size\": $SIZE,"
	echo "            \"url\": \""$URL"\","
	echo "        },"
done 

EPOCH=`date +%s`
echo "    \"folders\": {
        \"/docs\": {},
        \"/docs/nes\": {},
        \"/docs/nes/manuals\": {},
    },
    \"timestamp\": $EPOCH ,
}"
