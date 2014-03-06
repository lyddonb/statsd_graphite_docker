{
  graphiteHost: process.env.GRAPH_PORT_2003_TCP_ADDR,
  graphitePort: parseInt(process.env.GRAPH_PORT_2003_TCP_PORT),
  port: 8080,
  flushInterval: 10000,
  debug: true,
  dumpMessages: true,
  backends: ["./backends/graphite"]
}
