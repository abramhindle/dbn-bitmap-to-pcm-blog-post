#!/bin/bash
FILE=$1
PWD=`pwd`
O1="`basename $PWD`-`basename \"$FILE\"`-deeplearn$2.mkv"
O2="`basename $PWD`-`basename \"$FILE\"`-granular-deeplearn$2.mkv"
time python videosonify.py "$FILE"
mencoder -ovc copy -audiofile out.wav -oac copy "$FILE" -o "$O1"
python out-2-csound.py > grain.sco
csound -o output.wav grain.orc grain.sco
# mplayer -audiofile output.wav *mkv
mencoder -ovc copy -audiofile output.wav -oac copy "$FILE" -o "$O2"
to-webm "$O1" && rm "$O1"
to-webm "$O2" && rm "$O2"
