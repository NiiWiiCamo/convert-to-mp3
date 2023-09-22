#!/bin/bash

WATCHFOLDER="/watch"
OUTPUTFOLDER="/output"

echo "looking for $FORMAT_IN files to convert to $FORMAT_OUT in $WATCHFOLDER"

convert_format() {
  ffmpeg -nostdin -hide_banner -nostats -loglevel panic -vn -y -i "${file}" "${file%.*}.${FORMAT_OUT}"
  echo "converted ${file}"
}

remove_sourcefile() {
  echo "NOT removing source file"
  # rm "${file}"
}

move_directory() {
  echo "move folder:"
  echo "${dirname}"
  # echo "${file}"
  # mv ${WATCHFOLDER} ${OUTPUTFOLDER}
}

while $true:
do
  find ${WATCHFOLDER} -name "*.${FORMAT_IN}" -print0 |
  while IFS= read -r -d '' file
  do
    echo "file: ${file}"
    dirname="$(dirname ${file})"
    echo "dirname: ${dirname}"
    if [[ ${file##*.} == "${FORMAT_IN}" ]]
    then
      echo "mp4"
      convert_format && \
      remove_sourcefile && \
      move_directory
    fi
  done
  sleep 5
done
