#!/bin/bash

convert_mp3() {
    ffmpeg -hide_banner -nostats -loglevel panic -vn -y -i "/watch/${file}" "/output/${file%.*}.mp3" && \
    echo "converted ${file}"
}

while true; do
    inotifywait -t 5 -m /watch -e create -e moved_to -e modify | while read path action file
    do
        if [ ${file##*.} == "mp4" ]
        then
            convert_mp3 && rm "/watch/${file}"
        fi
    done
done