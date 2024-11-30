FROM docker.gh-proxy.com/docker.io/library/ubuntu:latest

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Shanghai

#for test 
# RUN mkdir -p /var/cache/apt/archives/partial 


# RUN apt-get update
# RUN apt-get install -yq software-properties-common tzdata
RUN apt-get update \
    && apt-get install -yq software-properties-common tzdata
RUN add-apt-repository ppa:jonathonf/ffmpeg-4
RUN apt-get install ffmpeg -y

ENV TIMEOUT_BUFFER 30
ENV LOG_LEVEL error

COPY record.sh /app/record.sh

ENTRYPOINT ["/app/record.sh"]
