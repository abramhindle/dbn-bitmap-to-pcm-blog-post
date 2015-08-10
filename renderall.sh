for file in ../../sample/*.{mkv,mov,mp4}
do
	echo $file
	bash ../render.sh $file
done
