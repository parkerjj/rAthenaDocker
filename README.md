# rAthena on Raspberry Pi

This is a server-only rAthena stack. It does not mount, serve, or start
ROWeb. ROWeb remains independent at `/ROWeb`.

The stack builds rAthena for PACKETVER 20211103 and uses the three packet
obfuscation keys configured in ROWeb v2. Runtime configuration is rendered to
the host under `config/import` and mounted read-only into the rAthena
containers.

Requirements:

- Raspberry Pi OS 64-bit with Docker Engine and Docker Compose plugin.
- `ro.io-ft.com` resolves to the server address used by the client.
- Allow TCP ports 6900, 6121, and 5121 through the server firewall/router.

Deploy on the Pi:

```sh
cd /rAthena/deploy/rathena-pi
chmod 600 .env
docker compose up -d --build
```

The `.env` file controls the packet version, all packet keys, host paths,
database settings, rAthena advertised addresses, Docker addresses, and port
bindings. Replace the two generated database passwords only if you want to
use different credentials.

The `本地内网` ROWeb v2 profile targets `ro.io-ft.com:6900`. This Compose
project only provides the rAthena TCP services; the separately hosted ROWeb
client and any required browser transport remain outside this project.

Useful commands:

```sh
docker compose ps
docker compose logs -f login char map
docker compose down
```

Database files and logs are bind-mounted under `/rAthena` and are not removed
by `docker compose down`.
