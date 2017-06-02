FROM ubuntu:xenial
MAINTAINER Muhammad Salehi <salehi1994@gmail.com>
ENV DEBIAN_FRONTEND noninteractive
ENV COVERALLS_TOKEN [secure]
ENV CXX g++
ENV CC gcc
ADD sources.list /etc/apt/sources.list
RUN apt-get update ;\
    apt-get install net-tools ethtool inetutils-ping git wget redis-server g++ gcc build-essential libglib2.0 libxml2-dev libpcap-dev librrd-dev redis-server libsqlite3-dev zip unzip bison flex libglib2.0 libxml2-dev libpcap-dev libtool rrdtool librrd-dev autoconf automake autogen redis-server wget libsqlite3-dev libhiredis-dev libgeoip-dev libpango1.0-dev libcairo2-dev libpng12-dev libmysqlclient-dev libnetfilter-queue-dev libmysqlclient-dev zlib1g-dev libzmq3-dev libssl-dev libtool-bin libmariadb-client-lgpl-dev libcurl4-gnutls-dev less vim screen curl supervisor -y ;\
    mkdir /opt/ntop/ ;\
    cd /opt/ntop/ ;\
    git clone --progress --verbose --depth=1 --branch=dev https://github.com/ntop/ntopng ; \
    cd ntopng; git clone --progress --verbose --depth=1 --branch=dev https://github.com/ntop/nDPI ;\
    cd nDPI; ./autogen.sh; make; cd .. ;\
    ./autogen.sh; ./configure; make geoip; make; make install ;\
    mkdir /etc/ntopng/ /var/log/ntopng/ ;\
    touch /etc/ntopng/ntopng.start ;\
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
ADD ntopng.conf /etc/ntopng/
ADD superv.conf /etc/supervisor/conf.d/
ENTRYPOINT ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
