# caddy

[Caddyserver](https://github.com/caddyserver/caddy/) with the following modules included:

* [Cloudflare DNS module](https://github.com/caddy-dns/cloudflare)
* [caddy2-filter](https://github.com/sjtug/caddy2-filter)

## example

```
  caddy:
    image: ghcr.io/xnaas/caddy:stable
    container_name: caddy
    restart: unless-stopped
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./caddy/Caddyfile:/etc/caddy/Caddyfile:ro
      - ./caddy/data:/data
      - ./caddy/config:/config
```
