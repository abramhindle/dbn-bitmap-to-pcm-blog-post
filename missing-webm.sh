set -e
PWD=`pwd`
NAME=`basename $PWD`
for file in *.mkv
do
	file2=`basename "$file"`
	F="${NAME}-${file2}"
	mv "$file" "$F"
	to-webm "$F"
	rm "$F"
done
