FROM ubuntu:latest

RUN apt-get update &&\
    apt-get install -y ffmpeg inotify-tools &&\
    apt-get clean

ENV FORMAT_IN="mp4"
ENV FORMAT_OUT="mp3"

COPY convert-mp3.sh /app/script.sh
RUN chmod +x /app/script.sh

ENTRYPOINT [ "/app/script.sh" ]