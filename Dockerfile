FROM node:8.0.0
MAINTAINER "S M Y ALTAMASH" "smy.altamash@gmail.com"
WORKDIR /home/enc
COPY . /home/enc
RUN npm -v
RUN rm /etc/apt/sources.list
RUN echo "deb http://archive.debian.org/debian/ jessie main" | tee -a /etc/apt/sources.list
RUN echo "deb-src http://archive.debian.org/debian/ jessie main" | tee -a /etc/apt/sources.list
RUN echo "Acquire::Check-Valid-Until false;" | tee -a /etc/apt/apt.conf.d/10-nocheckvalid
RUN echo 'Package: *\nPin: origin "archive.debian.org"\nPin-Priority: 500' | tee -a /etc/apt/preferences.d/10-archive-pin
RUN apt update \
    && apt install -y --force-yes zip python make g++ \
    && npm i \
    && apt remove --purge -y --force-yes python make g++ \
    && apt-get autoremove -y  \
    && rm -rf /var/lib/apt/lists/*
EXPOSE 8013
CMD sh entrypoint.sh
