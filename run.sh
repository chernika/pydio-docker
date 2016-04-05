#!/bin/sh

# mounting Google Cloud volume
if [ -d /mount/gce-volume ]; then
  rm -rf /var/www/pydio-core/data && ln -s /mount/gce-volume/pydio /var/www/pydio-core/data
  rm -rf /var/lib/mysql && ln -s /mount/gce-volume/mysql/ /var/lib/mysql
fi

# reset permissions on log volumes
chown -R www-data:www-data /var/www/pydio-core
chown -R www-data:www-data /mount/gce-volume/pydio/
chown -R mysql:mysql /mount/gce-volume/mysql/

chmod -R 770 /var/www/pydio-core
chmod 777  /var/www/pydio-core/data/files/
chmod 777  /var/www/pydio-core/data/personal/

# startup
exec supervisord -c /etc/supervisor/supervisord.conf