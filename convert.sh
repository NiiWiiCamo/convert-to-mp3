#!/bin/bash

# FORMAT_IN=${FORMAT_IN:"mp4"}
# FORMAT_OUT=${FORMAT_OUT:"mp3"}
WATCHFOLDER="/watch"
OUTPUTFOLDER="/output"

echo "looking for $FORMAT_IN files to convert to $FORMAT_OUT in $WATCHFOLDER"

convert_format() {
  ffmpeg -hide_banner -nostats -loglevel panic -vn -y -i "${WATCHFOLDER}/${file}" "${WATCHFOLDER}/${file%.*}.${FORMAT_OUT}" && \
  echo "converted ${file}"
}

remove_sourcefile() {
  rm "${WATCHFOLDER}/${file}"
}

move_directory() {
  mv ${WATCHFOLDER} ${OUTPUTFOLDER}
}

while $true:
do
  find ${WATCHFOLDER} -name "*.${FORMAT_IN}" -print0 |
  while IFS= read -r -d '' file
  do
    echo "file: ${file}"
    if [[ ${file##*.} == "${FORMAT_IN}" ]]
    then
      convert_format && \
      remove_sourcefile
    fi
  done
done
