FROM caddy:2.7.6-builder AS builder


RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/mholt/caddy-webdav \
    --with github.com/caddyserver/replace-response

FROM caddy:2.7.6

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
