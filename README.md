# Self-hosted Converse.js server

## Build

```console
docker build -t conversejs --build-arg VERSION=4.0.5 .
```

## Run

```console
docker run -d -p 8000:8000 conversejs
```
