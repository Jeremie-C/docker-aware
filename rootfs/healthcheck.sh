#!/usr/bin/env bash
set -e
EXITCODE=0

CHECK_DELAY=300

TSTAMP_NOW=$(date +%s.%N)
LASTLOG_LINE=$(grep "Packets sent in the last 30 seconds" /var/log/rbfeeder.log | tail -1 | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g")
LASTLOG_TSTAMP=$(date --date="$(echo "$LASTLOG_LINE" | cut -d '[' -f 2 | cut -d ']' -f 1)" +%s.%N)
LASTLOG_PACKETS=$(echo "$LASTLOG_LINE" | cut -d ']' -f 2 | cut -d ':' -f 2 | cut -d ',' -f 1 | tr -d ' ')

# check to make sure we've sent packets recently
if [ "$(echo "($TSTAMP_NOW - $LASTLOG_TSTAMP) < $CHECK_DELAY" | bc)" -ne 1 ]; then
    echo "No packets sent in past $CHECK_DELAY seconds. UNHEALTHY"
    EXITCODE=1
else
    if [ "$LASTLOG_PACKETS" -lt 1 ]; then
        echo "No packets sent in past $CHECK_DELAY seconds. UNHEALTHY"
        EXITCODE=1
    else
        echo "$LASTLOG_PACKETS packets sent in past 30 seconds. HEALTHY"
    fi
fi

exit $EXITCODE
