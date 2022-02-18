set -x 

cd /PATH/TO/WORK/DIR/
find -type d | sort | while read DIR 
do 
cd "$DIR"

ls *jp2 | while read i 
do 

WIDTH=`exiftool "$i" | grep "Image Size"| awk '{print$4}'| awk -F "x" '{print$1}'`
HEIGHT=`exiftool "$i" | grep "Image Size"| awk '{print$4}'| awk -F "x" '{print$2}'`
ASPECT=$(($WIDTH / $HEIGHT))

echo ""$i" Width:"$WIDTH" x Height:"$HEIGHT" ASPECT:"$ASPECT""

if [ $ASPECT -eq 1 ]
	then
		convert "$i" -resize 1300x990! -quality 100 "$i.png"
fi

if [ $ASPECT -eq 2 ]
	then
		convert -crop 50%x100% +repage "$i" "$i.png" 
		convert "$i-0.png" -resize 1300x990! +repage -quality 100 "$i-0.png"
		convert "$i-1.png" -resize 1300x990! +repage -quality 100 "$i-1.png"
fi


done



ls *png | grep -v jp2$ | while read i 
do 

composite -geometry +150+180 "$i" ~/PATH/TO/NES-MiSTer-Background.jpg "$i-NES-MiSTer-Background.png" 
done

pwd
FILE=`ls *jp2 | head -1 | awk -F "_" '{print$1}'`
convert \*-NES-MiSTer-Background.png +repage -quality 75 "$FILE.pdf" 

rm -v *png 
cd /PATH/TO/WORK/DIR

done 

