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
    image: masipcat/conversejs:5.0.0
    ports:
      - 8000:8000
    environment:
      - WS_SERVICE_URL=wss://xmpp.example.com/ws/
    restart: always
```

## Build

```console
docker build -t conversejs --build-arg VERSION=v5.0.0 .
```
