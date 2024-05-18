FROM ubuntu:20.04

ENV TZ=Europe/Madrid
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update
RUN apt-get install curl -y
RUN apt-get install net-tools -y
RUN apt-get install dnsutils -y
RUN apt-get install firefox -y
RUN apt-get install -y iputils-ping
#RUN apt-get install midori -y
RUN apt-get install tcpdump -y
RUN apt-get install traceroute

#install Go and git, to build mkcert
RUN apt install git -y
RUN apt search golang-go -y && apt search gccgo-go -y && apt install golang-go -y
#Install Mkcert, running this container as authority of cert
RUN apt install libnss3-tools -y
RUN git clone https://github.com/FiloSottile/mkcert
WORKDIR  /mkcert
RUN go build  -ldflags "-X main.Version=$(git describe --tags)"
RUN mv ./mkcert /usr/local/bin/mkcert
WORKDIR  /
RUN mkcert -install
#delete unecesary software used to install mkcert
RUN apt remove git -y && apt remove golang-go -y && apt remove libnss3-tools -y
RUN apt autoremove -y && apt-get clean -y
#Create auto sign certificates for webservers and haproxy
RUN mkdir -p ./certificados/
RUN mkcert -key-file autokey.pem -cert-file autocert.pem example.com localhost 127.0.0.1 ::1 192.168.3.0 192.168.3.9 192.168.3.10 192.168.3.11 192.168.3.12 192.168.3.16
#Script to run automatically tcpdump and store the capture in mounted volume /tmp/capture
RUN echo '#! /bin/sh'  >> /bin/wireshark
RUN echo '/usr/sbin/tcpdump -i eth0 -w /tmp/capture/$1' >> /bin/wireshark
RUN chmod u+x /bin/wireshark
EXPOSE 5900
EXPOSE 22
RUN apt-get install x11vnc xvfb -y
RUN echo "exec firefox" > ~/.xinitrc && chmod +x ~/.xinitrc
ADD start.sh /
RUN chmod +x /start.sh
#copiamos los certificados y arrancamos X11 para interfaz grafica de Firefox
CMD ["/start.sh"]
