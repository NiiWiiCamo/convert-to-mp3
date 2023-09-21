FROM ubuntu:latest

RUN apt-get update &&\
    apt-get install -y ffmpeg inotify-tools &&\
    apt-get clean

COPY convert-mp3.sh /app/script.sh
RUN chmod +x /app/script.sh

ENTRYPOINT [ "/app/script.sh" ]