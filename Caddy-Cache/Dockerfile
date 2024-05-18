FROM caddy:2-builder-alpine AS builder

RUN xcaddy build \ 
	--with github.com/caddyserver/cache-handler
    
FROM caddy:2-alpine 

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
RUN apk update && apk add tcpdump
RUN echo '#! /bin/sh' >> /bin/wireshark
RUN echo '/usr/bin/tcpdump -i eth0 -w /tmp/capture/$1' >> /bin/wireshark
RUN chmod u+x /bin/wireshark
