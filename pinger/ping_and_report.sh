#!/bin/bash
# You need to be running the node-exporter with:
# /usr/bin/prometheus-node-exporter --collector.textfile.directory=/tmp

# Example:
# --- google.ie ping statistics ---
# 3 packets transmitted, 3 received, 0% packet loss, time 2003ms
# rtt min/avg/max/mdev = 12.091/14.838/19.212/3.126 ms
# 14.838

ping_host() {
	HOST=$1
	echo "$(ping ${HOST} -c 5 | grep 'avg' | awk -F/ '{ print $5 }')"
}

# write to a temp file first
echo "# HELP ping_time_ms Ping latency averaged from five packets sent." > /tmp/.pinger.prom
echo "# TYPE ping_time_ms gauge" >> /tmp/.pinger.prom

for HOST in google.ie ring.local
do
	TIME=$( ping_host ${HOST})

	# send to syslog and stderr
	logger --tag 'pinger' --id --stderr "Average ping time for ${HOST} is ${TIME} ms"

	# and allow Promethesus to consume it too
	# https://stackoverflow.com/a/68627646
	echo "ping_time_ms{host=\"${HOST}\"} ${TIME}" >> /tmp/.pinger.prom
done

# and then atomically replace the one node-exporter consumes
mv --force /tmp/.pinger.prom /tmp/pinger.prom
