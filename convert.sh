#!/bin/bash

# FORMAT_IN=${FORMAT_IN:"mp4"}
# FORMAT_OUT=${FORMAT_OUT:"mp3"}
WATCHFOLDER="/watch"
OUTPUTFOLDER="/output"

echo "looking for $FORMAT_IN files to convert to $FORMAT_OUT in $WATCHFOLDER"

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

while $true:
do
  for file in $(find ${WATCHFOLDER} -name "*.${FORMAT_IN}")
  do
    echo "${file}"
    if [[ ${file##*.} == "${FORMAT_IN}" ]]
    then
      convert_format && \
      remove_sourcefile && \
      move_directory
    fi
  done
done
