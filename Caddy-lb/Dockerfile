FROM ubuntu:20.04

RUN apt-get update && apt-get install -y tcpdump
RUN apt-get install -y debian-keyring debian-archive-keyring apt-transport-https curl

RUN curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
RUN curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | tee /etc/apt/sources.list.d/caddy-stable.list

RUN apt-get update -y && apt-get install -y caddy
RUN mkdir -p /usr/share/caddy/www/

# VRRP
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC
RUN apt-get update && apt-get install -y keepalived iputils-ping
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# Agregar certificados creados por el equipo
COPY ./Certificados/ca-cert.pem /usr/local/share/ca-certificates/ca-cert.crt
COPY ./Certificados/ca-cert.pem /etc/ssl/certs/ca-cert.crt
RUN update-ca-certificates

CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile"]

RUN echo '#!/bin/sh' >> /bin/wireshark
RUN echo '/usr/bin/tcpdump -i eth0 -w /tmp/capture/$1' >> /bin/wireshark
RUN chmod u+x /bin/wireshark
