# Self-hosted Converse.js server

This image of `conversejs` is intended to run behind a reverse proxy with TLS support.

## Run

Using docker:
```console
docker run -d -p 8000:8000 masipcat/conversejs:latest
```

Using docker-compose:
```yaml
version: "3.3"
services:
  converse:
    image: masipcat/conversejs:4.2.0
    ports:
      - 8000:8000
    environment:
      - BOSCH_SERVICE_URL=https://xmpp.example.com/bosh/
      - WS_SERVICE_URL=wss://xmpp.example.com/ws/
    restart: always
```

## Build

```console
docker build -t conversejs --build-arg VERSION=v4.2.0 .
```
