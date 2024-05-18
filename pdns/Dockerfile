FROM ubuntu:20.04

ENV TZ=Europe/Madrid
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN echo '#! /bin/sh' > /bin/wireshark && \
    echo '/usr/sbin/tcpdump -i eth0 -w /tmp/capture/$1' >> /bin/wireshark && \
    chmod u+x /bin/wireshark

RUN apt-get update && \
    apt-get install -y pdns-server pdns-backend-bind tcpdump nano && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/powerdns/zones/ && \
    touch /etc/powerdns/zones/web.com.zone && \
    chown -R root:root /etc/powerdns/zones/

RUN mkdir -p /etc/powerdns/zones/ && \
    touch /etc/powerdns/zones/lb.com.zone && \
    chown -R root:root /etc/powerdns/zones/

EXPOSE 53/tcp 53/udp
CMD ["pdns_server", "--daemon=no", "--guardian=no", "--loglevel=9"]

