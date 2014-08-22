#!/bin/sh -x

if [ ! -d /opt/graphite/storage/whisper ]
then
    cp -r /opt/graphite/storage.bak/* /opt/graphite/storage/
    chown -R www-data /opt/graphite/storage
fi

