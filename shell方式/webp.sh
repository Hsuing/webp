#!/bin/bash

LOCATION="/data/wwwroot/images"
FILES="png|jpg|gif|PNG|JPG|GIF"

process() {

DEBUG=1
SLEEP_DELAY=0.5

        FILE="$1"
STARTTIME=$(date +%s)
        if [ -f "$FILE".webp ]
        then
                FILE_ORIG=$(stat -c %Y "$FILE")
                FILE_GZIP=$(stat -c %Y "$FILE".webp)
                if [ $FILE_ORIG -gt $FILE_GZIP ]
                then
                        rm "$FILE".webp
                        EXTENSION=$(echo "$FILE" | awk -F . '{print $NF}' | awk '{print tolower($0)}')
                        if [ "$EXTENSION" == "gif" ]
then
gif2webp -q 100 -m 6 -mt "$FILE" -o "$FILE".webp
touch "$FILE".webp -r "$FILE"
if [ "$DEBUG" == 1 ]
then
echo "Replaced old GIF WebP with: $FILE.webp"
fi
ENDTIME=$(date +%s)
WAITTIME=$((($ENDTIME-$STARTTIME)*4))
if [ $WAITTIME -gt 1 ]
then
echo "Sleeping $WAITTIME..."
sleep $WAITTIME
fi
sleep $SLEEP_DELAY
elif [ "$EXTENSION" == "png" ]
then
cwebp -q 100 -m 6 -mt -lossless -short "$FILE" -o "$FILE".webp
                                touch "$FILE".webp -r "$FILE"
if [ "$DEBUG" == 1 ]
then
echo "Replaced old PNG WebP with: $FILE.webp"
fi
                                ENDTIME=$(date +%s)
                                WAITTIME=$((($ENDTIME-$STARTTIME)*4))
if [ $WAITTIME -gt 1 ]
then
echo "Sleeping $WAITTIME..."
sleep $WAITTIME
fi
                                sleep $SLEEP_DELAY
elif [ "$EXTENSION" == "jpg" ]
then
cwebp -q 80 -m 6 -mt -short "$FILE" -o "$FILE".webp
                                touch "$FILE".webp -r "$FILE"
if [ "$DEBUG" == 1 ]
then
echo "Replaced old JPG WebP with: $FILE.webp"
fi
                                ENDTIME=$(date +%s)
                                WAITTIME=$((($ENDTIME-$STARTTIME)*4))
if [ $WAITTIME -gt 1 ]
then
echo "Sleeping $WAITTIME..."
sleep $WAITTIME
fi
                                sleep $SLEEP_DELAY
else
echo "Could not match extension of the file $FILE !"
fi
else
echo "Skipping already up to date: $FILE.webp"
fi
        else

                EXTENSION=$(echo "$FILE" | awk -F . '{print $NF}' | awk '{print tolower($0)}')
                if [ "$EXTENSION" == "gif" ]
                then
                        gif2webp -q 100 -m 6 -mt "$FILE" -o "$FILE".webp
                        touch "$FILE".webp -r "$FILE"
                        if [ "$DEBUG" == 1 ]
                        then
                                echo "Created new GIF WebP at: $FILE.webp"
                        fi
                        ENDTIME=$(date +%s)
                        WAITTIME=$((($ENDTIME-$STARTTIME)*4))
if [ $WAITTIME -gt 1 ]
then
echo "Sleeping $WAITTIME..."
sleep $WAITTIME
fi
                        sleep $SLEEP_DELAY
                elif [ "$EXTENSION" == "png" ]
                then
                        cwebp -q 100 -m 6 -mt -lossless -short "$FILE" -o "$FILE".webp
                        touch "$FILE".webp -r "$FILE"
                        if [ "$DEBUG" == 1 ]
                        then
                                echo "Created new PNG WebP at: $FILE.webp"
                        fi
                        ENDTIME=$(date +%s)
                        WAITTIME=$((($ENDTIME-$STARTTIME)*4))
if [ $WAITTIME -gt 1 ]
then
echo "Sleeping $WAITTIME..."
sleep $WAITTIME
fi
                        sleep $SLEEP_DELAY
                elif [ "$EXTENSION" == "jpg" ]
                then
                        cwebp -q 80 -m 6 -mt -short "$FILE" -o "$FILE".webp
                        touch "$FILE".webp -r "$FILE"
                        if [ "$DEBUG" == 1 ]
                        then
                                echo "Created new JPG WebP at: $FILE.webp"
                        fi
                        ENDTIME=$(date +%s)
                        WAITTIME=$((($ENDTIME-$STARTTIME)*4))
if [ $WAITTIME -gt 1 ]
then
echo "Sleeping $WAITTIME..."
sleep $WAITTIME
fi
                        sleep $SLEEP_DELAY
                else
                        echo "Could not match extension of the file $FILE !"
                fi
        fi
}
export -f process

find $LOCATION -type f -regextype posix-extended -regex '.*\.('$FILES')' -exec /bin/bash -c 'process "{}"' \;