#!/bin/bash

# FORMAT_IN=${FORMAT_IN:"mp4"}
# FORMAT_OUT=${FORMAT_OUT:"mp3"}
WATCHFOLDER="/watch"
OUTPUTFOLDER="/output"

echo "looking for $FORMAT_IN files to convert to $FORMAT_OUT"

convert_format() {
  ffmpeg -hide_banner -nostats -loglevel panic -vn -y -i "$path/${file}" "$path/${file%.*}.${FORMAT_OUT}" && \
  echo "converted ${file}"
}

remove_sourcefile() {
  rm "${path}/${file}"
}

move_directory() {
  mv ${path} ${OUTPUTFOLDER}
}

inotifywait -rm $WATCHFOLDER -e create| while read path action file
do
  echo "path: ${path} / ${file}"
  echo "action: $action"
  if [[ ${file##*.} == "${FORMAT_IN}" ]]
  then
    convert_format && \
    remove_sourcefile && \
    move_directory
  fi
done
