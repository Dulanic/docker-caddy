###########
# builder #
FROM golang:1.18-alpine AS src
ARG CADDY_VERSION

RUN apk --no-cache add wget ca-certificates

WORKDIR /src
RUN wget https://github.com/caddyserver/caddy/raw/master/cmd/caddy/main.go
RUN sed -i '34i\\t_ "github.com/caddy-dns/cloudflare"' main.go
RUN go mod init caddy
RUN go get github.com/caddyserver/caddy/v2@$CADDY_VERSION
RUN go mod tidy
RUN CGO_ENABLED=0 go build
# https://w.wiki/JQC
RUN wget https://raw.githubusercontent.com/xnaas/webserver/master/caddy/mime.types
# required for 'netgo'
RUN /bin/echo 'hosts: files dns' > nsswitch.conf

#############
# container #
FROM scratch
COPY --from=src /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=src /src/caddy /bin/caddy
COPY --from=src /src/mime.types /etc/mime.types
COPY --from=src /src/nsswitch.conf /etc/nsswitch.conf

# https://caddyserver.com/docs/conventions#file-locations
ENV XDG_CONFIG_HOME /config
ENV XDG_DATA_HOME /data
VOLUME /config
VOLUME /data

# default ports
EXPOSE 80
EXPOSE 443
EXPOSE 2019

# same location as official caddy docker for compatibility
CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]
