#!/bin/bash

convert_mp3() {
    ffmpeg -hide_banner -nostats -loglevel panic -i -vn -y /watch/$file /output/${file%.*}.mp3 &
    echo "converting $file"
}

while true; do
    inotifywait -t 5 -q -m /watch/ -e create -e moved_to --include '.*\.mp4$' | while read path action file
    do
        if [ ${file##*.} != "mp3" ]
        then
            convert_mp3 && rm /watch/${file}
        fi
    done
done