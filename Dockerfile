FROM ubuntu
RUN apt-get

RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN echo "deb http://ppa.launchpad.net/rethinkdb/ppa/ubuntu precise main" >> /etc/apt/sources.list
RUN apt-get -y update

RUN apt-get -y install python-ldap python-cairo python-django python-twisted \
        python-django-tagging python-simplejson python-memcache python-pysqlite2 \
        python-support python-pip gunicorn supervisor nginx-light

RUN apt-get install -y --force-yes nodejs
RUN apt-get install -y --force-yes git

RUN pip install --upgrade pip
RUN pip install whisper
RUN pip install --install-option="--prefix=/var/lib/graphite" --install-option="--install-lib=/var/lib/graphite/lib" carbon
RUN pip install --install-option="--prefix=/var/lib/graphite" --install-option="--install-lib=/var/lib/graphite/webapp" graphite-web

ADD ./configs/nginx.conf /etc/nginx/nginx.conf
ADD ./configs/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD ./configs/initial_data.json /var/lib/graphite/webapp/graphite/initial_data.json
ADD ./configs/local_settings.py /var/lib/graphite/webapp/graphite/local_settings.py
ADD ./configs/carbon.conf /var/lib/graphite/conf/carbon.conf
ADD ./configs/storage-schemas.conf /var/lib/graphite/conf/storage-schemas.conf
ADD ./configs/storage-aggregation.conf /var/lib/graphite/conf/storage-aggregation.conf

RUN mkdir -p /var/lib/graphite/storage/whisper
RUN touch /var/lib/graphite/storage/graphite.db /var/lib/graphite/storage/index
RUN chown -R www-data /var/lib/graphite/storage
RUN chmod 0775 /var/lib/graphite/storage /var/lib/graphite/storage/whisper
RUN chmod 0664 /var/lib/graphite/storage/graphite.db
RUN cd /var/lib/graphite/webapp/graphite && python manage.py syncdb --noinput
VOLUME  /var/lib/graphite

RUN mkdir -p /var/lib/statsd
WORKDIR /var/lib/statsd
RUN git clone https://github.com/etsy/statsd.git
ADD config.js /var/lib/statsd/config.js

# Make sure to expose these ports in the run command
#graphite web
EXPOSE  80
#graphite cache input
EXPOSE  2003
EXPOSE  2004
EXPOSE  7002

#statsd
EXPOSE  8125/udp
#statsd admin
EXPOSE  8126

CMD ["/usr/bin/supervisord", "-n"]
