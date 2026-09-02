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
- Allow TCP ports 6900, 6121, 5121, and 6901 through the server firewall/router.

For Dokploy, create a GitHub project from this repository and select the
root-level `docker-compose.yml`. The repository is server-only; it does not
contain or mount ROWeb client resources.

Deploy on the Pi:

```sh
cd /path/to/rathenaDocker
chmod 600 .env
docker compose up -d --build
```

The `.env` file controls the packet version, all packet keys, host paths,
database settings, rAthena advertised addresses, Docker addresses, and port
bindings. Replace the two generated database passwords only if you want to
use different credentials.

The `本地内网` ROWeb v2 profile targets `ro.io-ft.com:6900`. The
`socket-proxy` service listens on host port `6901` and translates browser
WebSocket traffic into TCP connections to the rAthena login service on
`login:6900`. Configure the separately hosted ROWeb Nginx to proxy the
WebSocket path `/ro.io-ft.com:6900` to this service. ROWeb client resources
remain outside this project.

Useful commands:

```sh
docker compose ps
docker compose logs -f login char map socket-proxy
docker compose down
```

Database files and logs are bind-mounted under `/rAthena` and are not removed
by `docker compose down`.
