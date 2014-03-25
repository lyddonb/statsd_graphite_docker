ping:
	nc -z -w5 127.0.0.1 8125; echo $?

gcenetwork:
	gcutil addfirewall statsd --allowed=tcp:80,tcp:4443,udp:8125

kill:
	unlink /var/run/supervisor.sock

ports:
	netstat -tulpn
