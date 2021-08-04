# docker-RadarBoxFeeder

![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/jeremiec82/radarbox?style=plastic)
![Docker Pulls](https://img.shields.io/docker/pulls/jeremiec82/radarbox?style=plastic)
[![Deploy to Docker Hub](https://github.com/Jeremie-C/docker-aware/actions/workflows/deploy.yml/badge.svg)](https://github.com/Jeremie-C/docker-aware/actions/workflows/deploy.yml)
[![Check Code](https://github.com/Jeremie-C/docker-aware/actions/workflows/check_code.yml/badge.svg)](https://github.com/Jeremie-C/docker-aware/actions/workflows/check_code.yml)
[![Docker Build](https://github.com/Jeremie-C/docker-aware/actions/workflows/test_build.yml/badge.svg)](https://github.com/Jeremie-C/docker-aware/actions/workflows/test_build.yml)

Docker container to feed ADS-B data into [AirNav RadarBox](https://www.radarbox.com).

## Environment Variables

| Environment Variable | Purpose | Default |
| -------------------- | ------- | ------- |
| `BEAST_HOST` | Required. IP/Hostname of a Mode-S/BEAST provider (readsb) | |
| `BEAST_PORT` | Optional. TCP port number of Mode-S/BEAST provider (readsb) | `30005` |
| `RBFEEDER_KEY` | Required. Your static UUID |  |
| `LATITUDE`   | Required. The latitude of the antenna |  |
| `LONGITUDE`  | Required. The longitude of the antenna |  |
| `ALTITUDE`   | Required. The altitude of the antenna , must include either 'm' or 'ft' suffix to indicate |  |
| `STATS_INTERVAL` | Optional. Print stats to container every STATS_INTERVAL minutes | `5` |
| `TZ`         | Optional. Your local timezone | `GMT` |

## Ports

| Port | Detail |
| ---- | ------ |
| 30105/tcp | MLAT Results Beast protocol output. Optional. Allow other applications outside docker host to receive MLAT results |
