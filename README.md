# docker-RadarBoxFeeder

Docker container to feed ADS-B data into [AirNav RadarBox](https://www.radarbox.com).

## Environment Variables

| Environment Variable | Purpose | Default |
| -------------------- | ------- | ------- |
| `BEAST_HOST` | Required. IP/Hostname of a Mode-S/BEAST provider (readsb) |         |
| `BEAST_PORT` | Optional. TCP port number of Mode-S/BEAST provider (readsb) | `30005`   |
| `RBFEEDER_KEY` | Required. Your static UUID |  |
| `LATITUDE`   | Required. The latitude of the antenna |  |
| `LONGITUDE`  | Required. The longitude of the antenna |  |
| `ALTITUDE`   | Required. The altitude of the antenna , must include either 'm' or 'ft' suffix to indicate |  |
| `TZ`         | Optional. Your local timezone | `GMT` |

## Ports

| Port | Detail |
| ---- | ------ |
| 30105/tcp | MLAT Results Beast protocol output. Optional. Allow other applications outside docker host to receive MLAT results |
