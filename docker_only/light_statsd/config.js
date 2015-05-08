{
  graphiteHost: "127.0.0.1",
  graphitePort: 2003,
  port: 8125,
  flushInterval: 10000,
  debug: false,
  dumpMessages: false,
  backends: ["./backends/graphite"],
  deleteIdleStats: true,
  percentThreshold: [90, 95, 99],
  metricToggles: {
    "std": true,
    "upper": true,
    "lower": true,
    "count": true,          // counts per flushInterval
    "count_ps": true,       // counts per second
    "sum": false,           // sums of timer values for each percentThreshold
    "sum_squares": false,   // sums of squares of timer values for each percentThreshold
    "mean": true,
    "median": true,
  }
}
