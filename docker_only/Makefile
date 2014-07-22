

build:
	docker build -t statsd .

run:
	docker run --name statsd -p 80:80 -p 2003:2003 -p 2004:2004 -p 7002:7002 -p 8125:8125/udp -p 8126:8126 -v /var/log/supervisor:/var/log/supervisor -d statsd

debug: 
	docker run --name statsd -i -p 80:80 -p 2003:2003 -p 2004:2004 -p 7002:7002 -p 8125:8125/udp -p 8126:8126 -v /var/log/supervisor:/var/log/supervisor statsd

ping:
	nc -z -w5 127.0.0.1 8125; echo $?

gcedocker:
	curl get.docker.io | bash
	sudo update-rc.d docker defaults

gcenetwork:
	gcutil addfirewall statsd --allowed=tcp:80,tcp:4443,udp:8125

clearcontainers:
	sudo docker rm -v `sudo docker ps -a -q`
