.. _installation:

============
Installation
============

This installation guide is written for Debian Stretch.

Docker and helfertoolctl
------------------------

First, install Docker according to the `Docker documentation <https://docs.docker.com/install/linux/docker-ce/debian/>`_.

The `helfertoolctl` package can be installed from the Debian repository https://repo.helfertool.org/debian/:

.. code-block:: none

   sudo apt install apt-transport-https dirmngr

   echo "deb https://repo.helfertool.org/debian/ stretch main" | sudo tee /etc/apt/sources.list.d/helfertool.list

   sudo apt-key adv --recv-keys FA1023F9F6AC494F

   sudo apt update
   sudo apt install helfertoolctl

The available Debian and CentOS repositories are listed in the section about :ref:`helfertoolctl`.

Database
--------

PostgreSQL is the recommended database for Helfertool deployments.

PostgreSQL
^^^^^^^^^^
.. code-block:: none

   sudo apt install postgresql

Then create an user and database:

.. code-block:: none

   sudo -u postgres createuser -P helfertool
   sudo -u postgres createdb -O helfertool helfertool

By default, PostgreSQL only listens to localhost. To allow access from the Docker container,
the following configuration files need to be modified:

.. code-block:: none
   :caption: /etc/postgresql/9.6/main/postgresql.conf

   listen_addresses = '*'

.. code-block:: none
   :caption: /etc/postgresql/9.6/main/pg_hba.conf

   # connection from docker container
   host    all             all             172.17.0.0/16           md5

Then restart PostgreSQL:

.. code-block:: none

   sudo systemctl restart postgresql

MariaDB
^^^^^^^

.. code-block:: none

   sudo apt install mariadb-server

Then create an user and database:

.. code-block:: none

   sudo mysql
   MariaDB [(none)]> CREATE DATABASE helfertool;
   MariaDB [(none)]> CREATE USER helfertool IDENTIFIED BY '<PASSWORD>';
   MariaDB [(none)]> GRANT ALL PRIVILEGES ON helfertool.* TO helfertool;
   MariaDB [(none)]> ALTER DATABASE helfertool CHARACTER SET utf8;

You probably have to load the time zone tables into the database, otherwise
you will see some strange Django errors:

.. code-block:: none

   mysql_tzinfo_to_sql /usr/share/zoneinfo | sudo mysql -u root mysql
   sudo systemctl restart mysql

.. TODO: more than localhost

RabbitMQ
--------

.. code-block:: none

   sudo apt install rabbitmq-server

A new user and virtualhost should be created in RabbitMQ, additionally the
default user ``guest`` should be deleted for security reasons.

.. code-block:: none

   sudo rabbitmqctl add_user helfertool <PASSWORD>
   sudo rabbitmqctl add_vhost helfertool
   sudo rabbitmqctl set_permissions -p helfertool helfertool '.*' '.*' '.*'
   sudo rabbitmqctl delete_user guest

Container download
------------------

.. code-block:: none

   sudo helfertoolctl download

Basic configuration
-------------------

Now edit the configuration file ``/etc/helfertool/helfertool.yaml`` and
configure at least the following settings:

 * Database
 * RabbitMQ
 * Mail server
 * Secret key (``security`` > ``secret``)
 * Allowed hosts (``security`` > ``allowed_hosts``)

.. TODO: explain, how to generate

Details about the configuration file can be found :ref:`here <configuration>`.

First start
-----------

Now is is time for the first start of the Helfertool, we should also enable the autostart here:

.. code-block:: none

   sudo systemctl enable --now helfertool

To check the progress, you can use ``journalctl``:

.. code-block:: none

   sudo journalctl -f -u helfertool

On the first start, the database migration are applied and after that the container is running and
listens on port 8000.

Reverse proxy
-------------

The webserver works as reverse proxy in front of the Docker container and
terminates the TLS connection.
The following section describes the setup with Apache and Nginx, but you
could also use tools like HAProxy or Varnish.
Nginx is the recommended choice as reverse proxy.

Nginx
^^^^^

.. code-block:: none

   sudo apt install nginx

Place the configuration in ``/etc/nginx/sites-available/helfertool.conf``,
review and adapt the settings carefully.

.. code-block:: none
   :caption: /etc/nginx/sites-available/helfertool.conf

   upstream helfertool {
           server 127.0.0.1:8000;
   }

   server {
           # server info
           listen 80 default_server;
           listen [::]:80 default_server;

           server_name app.helfertool.org www.app.helfertool.org;
           server_tokens off;

           # redirect to https
           return 301 https://$server_name$request_uri;

           # logging
           access_log /var/log/nginx/helfertool.log;
           error_log /var/log/nginx/helfertool_error.log error;
   }

   server {
           # server info
           listen 443 ssl http2 default_server;
           listen [::]:443 ssl http2 default_server;


           # tls config
           ssl_certificate /etc/letsencrypt/live/app.helfertool.org/chain.pem;
           ssl_certificate_key /etc/letsencrypt/live/app.helfertool.org/privkey.pem;

           ssl_protocols TLSv1.2;
           ssl_ciphers 'ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA256';
           ssl_prefer_server_ciphers on;

           add_header Strict-Transport-Security "max-age=15552000";

           #ssl_stapling on;
           #ssl_stapling_verify on;

           # redirect to "app.helfertool.org" if necessary (without www)
           if ($host != 'app.helfertool.org') {
                   return 301 https://app.helfertool.org$request_uri;
           }

           # proxy
           location / {
                   proxy_pass http://helfertool;

                   proxy_redirect     off;

                   proxy_set_header Host $host;
                   proxy_set_header X-Real-IP $remote_addr;
                   proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                   proxy_set_header X-Forwarded-Proto $scheme;
           }

           # proxy error page
           error_page 502 /unavailable.html;

           location = /unavailable.html {
                   root /usr/share/helfertool/;
                   internal;
           }

           # logging
           access_log /var/log/nginx/helfertool.log;
           error_log /var/log/nginx/helfertool_error.log error;
   }

Then activate the new vHost and if necessary disable the default vHost.

.. code-block:: none

   sudo ln -s /etc/nginx/sites-available/helfertool.conf /etc/nginx/sites-enabled/helfertool.conf
   sudo rm /etc/nginx/sites-enabled/default
   sudo systemctl restart nginx

Apache
^^^^^^

.. code-block:: none

   sudo apt install apache2

Place the configuration in ``/etc/apache2/sites-available/helfertool.conf``.

..
  the file is also in the git repository under ``stuff/deployment/apache.conf``.
  Review and adapt the settings carefully.

.. note::
   This configuration example is missing, sorry!

The Apache module remoteip needs to be enabled.
Then activate the new vHost and if necessary disable the default vHost.

.. code-block:: none

   sudo a2enmod remoteip

   sudo a2ensite helfertool.conf
   sudo a2dissite 000-default.conf  # for a new apache installation
   sudo a2enmod rewrite ssl headers
   sudo systemctl restart apache2

First steps
-----------

Try to access the website, it should work now!

To finalize the installation and create an admin account, run:

.. code-block:: none

   sudo helfertoolctl init
   sudo helfertoolctl createadmin
