pinger
======

Reports **averaged ping times** (to a specific host) over Prometheus `node-exporter` via [the `textfile` collector](https://github.com/prometheus/node_exporter?tab=readme-ov-file#textfile-collector).

### Example

```bash
# HELP node_textfile_mtime_seconds Unixtime mtime of textfiles successfully read.
# TYPE node_textfile_mtime_seconds gauge
node_textfile_mtime_seconds{file="/tmp/pinger.prom"} 1.73071789e+09

# HELP ping_time_ms Ping latency averaged from five packets sent.
# TYPE ping_time_ms gauge
ping_time_ms{host="google.ie"} 15.657
ping_time_ms{host="ring.local"} 7.094
```
