FROM ubuntu:precise

RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get -y update

RUN apt-get -y --force-yes install \
        git \
        gunicorn \
        nginx-light \
        nodejs \
        npm \
        python-cairo \
        python-django \
        python-django-tagging \
        python-ldap \
        python-memcache \
        python-pip \
        python-pysqlite2 \
        python-simplejson \
        python-support \
        python-twisted \
        supervisor \
        build-essential \
        python-dev \
        wget

RUN ln -s `which nodejs` /usr/bin/node

RUN pip install --upgrade pip
RUN pip install whisper daemonize
RUN pip install django==1.4
RUN pip install --install-option="--prefix=/opt/graphite" --install-option="--install-lib=/opt/graphite/lib" carbon
RUN pip install --install-option="--prefix=/opt/graphite" --install-option="--install-lib=/opt/graphite/webapp" graphite-web

RUN sed -i -e's/from twisted.scripts._twistd_unix import daemonize/import daemonize/g' /opt/graphite/lib/carbon/util.py

ADD ./configs/nginx.conf /etc/nginx/nginx.conf
ADD ./configs/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD ./configs/initial_data.json /opt/graphite/webapp/graphite/initial_data.json
ADD ./configs/local_settings.py /opt/graphite/webapp/graphite/local_settings.py
ADD ./configs/carbon.conf /opt/graphite/conf/carbon.conf
ADD ./configs/storage-schemas.conf /opt/graphite/conf/storage-schemas.conf
ADD ./configs/storage-aggregation.conf /opt/graphite/conf/storage-aggregation.conf

RUN mkdir -p /opt/graphite/storage/whisper
RUN touch /opt/graphite/storage/graphite.db /opt/graphite/storage/index
RUN chown -R www-data /opt/graphite/storage
RUN chmod 0775 /opt/graphite/storage /opt/graphite/storage/whisper
RUN chmod 0664 /opt/graphite/storage/graphite.db
RUN cd /opt/graphite/webapp/graphite && python manage.py syncdb --noinput

ADD ./copy_storage.sh /opt/graphite/bin/copy_storage.sh
RUN chmod a+x /opt/graphite/bin/copy_storage.sh

RUN mv /opt/graphite/storage /opt/graphite/storage.bak

RUN mkdir -p /opt/statsd
WORKDIR /opt/statsd
RUN git clone -b metric-toggles https://github.com/akgill/statsd.git
ADD config.js /opt/statsd/config.js

# install diamond
WORKDIR /tmp
RUN wget https://github.com/BrightcoveOS/Diamond/archive/v3.4.tar.gz
RUN tar xvfz v3.4.tar.gz
RUN pip install diamond python-statsd
ADD ./diamond/diamond.conf /etc/diamond/diamond.conf
RUN mkdir -p /usr/share/diamond/collectors
RUN cp ./Diamond-3.4/src/collectors/diskspace/diskspace.py /usr/share/diamond/collectors/diskspace.py
ADD ./diamond/collectors/DiskSpaceCollector.conf /etc/diamond/collectors/DiskSpaceCollector.conf
RUN cp ./Diamond-3.4/src/collectors/diskusage/diskusage.py /usr/share/diamond/collectors/diskusage.py
ADD ./diamond/collectors/DiskUsageCollector.conf /etc/diamond/collectors/DiskUsageCollector.conf

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
