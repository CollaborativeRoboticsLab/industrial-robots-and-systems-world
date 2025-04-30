# Industrial Robots and Systems Simulation World

## Use image avaialble online

```bash
docker compose pull
xhost +local:root
docker compose up
```

## Build image on locally

```bash
docker compose -f compose-build.yaml build
xhost +local:root
docker compose -f compose-build.yaml up
```
