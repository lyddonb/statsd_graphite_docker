{
  //graphiteHost: process.env.HOSTNAME,
  //graphitePort: parseInt(process.env.GRAPH_PORT_2003_TCP_PORT),
  graphiteHost: "127.0.0.1",
  graphitePort: 2003,
  port: 8125,
  flushInterval: 10000,
  debug: true,
  dumpMessages: true,
  backends: ["./backends/graphite"]
}
