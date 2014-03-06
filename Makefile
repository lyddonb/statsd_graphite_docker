

build:
	docker build -t statsd .

run:
	docker run -p 80:80 -p 2003:2003 -p 2004:2004 -p 7002:7002 -p 8125:8125/udp -v /var/log/supervisor:/var/log/supervisor -d statsd


debug: 
	docker run -i -p 80:80 -p 2003:2003 -p 2004:2004 -p 7002:7002 -p 8125:8125/udp -v /var/log/supervisor:/var/log/supervisor statsd

ping:
	nc -z -w5 127.0.0.1 8125; echo $?
