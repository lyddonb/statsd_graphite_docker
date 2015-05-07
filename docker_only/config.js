{
  graphiteHost: "127.0.0.1",
  graphitePort: 2003,
  port: 8125,
  flushInterval: 10000,
  debug: false,
  dumpMessages: false,
  backends: ["./backends/graphite"],
  deleteIdleStats: true,
  percentThreshold: [90, 95, 99]
}
