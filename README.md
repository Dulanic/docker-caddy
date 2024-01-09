# caddy

[Caddyserver](https://github.com/caddyserver/caddy/) with the following modules included:

* [Cloudflare DNS module](https://github.com/caddy-dns/cloudflare)
* [replace-response](https://github.com/caddyserver/replace-response)
* [Webdav](https://github.com/caddyserver/caddy-webdav)
* [Maxmind](github.com/porech/caddy-maxmind-geolocation)

```
  caddy:
    image: ghcr.io/Dulanic/caddy:stable
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
