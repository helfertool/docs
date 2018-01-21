.. _proxy:

=============
Reverse proxy
=============

The webserver has to work as reverse proxy in front of uWSGI and also serve
the static files.
The following section describes the setup with Apache and Nginx, but you
could also use tools like HAProxy or Varnish.

Apache
------

Place the configuration in ``/etc/apache2/sites-available/helfertool.conf``,
the file is also in the git repository under ``stuff/deployment/apache.conf``.
Review and adapt the settings carefully.

.. code-block:: none

   <VirtualHost *:80>
       ServerName app.helfertool.org
       ServerAlias www.app.helfertool.org
       ServerAdmin admin@helfertool.org

       ServerSignature Off

       # SSL redirect
       RewriteEngine On
       RewriteCond %{HTTPS} off
       RewriteRule ^.*$ https://%{SERVER_NAME}%{REQUEST_URI} [L,NE,R=permanent]

       # logging
       CustomLog "${APACHE_LOG_DIR}/helfertool_access.log" combined
       ErrorLog "${APACHE_LOG_DIR}/helfertool_error.log"
   </VirtualHost>

   <VirtualHost *:443>
       ServerName app.helfertool.org
       ServerAlias www.app.helfertool.org
       ServerAdmin admin@helfertool.org

       ServerSignature Off

       # reverse proxy and static files
       ProxyPassMatch ^/static/ !
       ProxyPassMatch ^/media/ !
       # let's encrypt (you additionally need an alias for the well-known directory)
       ProxyPassMatch ^/.well-known/ !
       ProxyPass / uwsgi://127.0.0.1:3001/
       ProxyPassReverse / uwsgi://127.0.0.1:3001/

       <Directory />
           Require all denied
       </Directory>

       Alias /static/ /srv/helfertool/helfertool/static/
       Alias /media/ /srv/helfertool/helfertool/media/

       <Directory /srv/helfertool/helfertool/static/>
           Require all granted
       </Directory>

       <Directory /srv/helfertool/helfertool/media/>
           Require all granted
       </Directory>

       # error document in case uwsgi is stopped
       ErrorDocument 503 /static/helfertool/unavailable.html

       # ssl settings
       SSLEngine on
       SSLCertificateFile /etc/ssl/certs/ssl-cert-snakeoil.pem
       SSLCertificateKeyFile /etc/ssl/private/ssl-cert-snakeoil.key

       Header set Strict-Transport-Security "max-age=15552000"

       # security options
       Header set X-Content-Type-Options nosniff
       Header set X-XSS-Protection "1; mode=block"
       Header set Content-Security-Policy "default-src: https: 'unsafe-inline'"

       # disable php
       SetHandler default-handler

       # redirect to "app.helfertool.org" if necessary (without www)
       # enable if app should only be served under one domain, this is recommended
       #RewriteEngine On [NC]
       #RewriteCond %{HTTP_HOST} !(^app\.helfertool\.org)
       #RewriteCond %{REQUEST_URI} !^/.well-known(.*)
       #RewriteRule ^(.*)$ https://app.helfertool.org/$1 [R=301,NC,L]

       # logging
       CustomLog "${APACHE_LOG_DIR}/helfertool_access.log" combined
       ErrorLog "${APACHE_LOG_DIR}/helfertool_error.log"
   </VirtualHost>

We have to add the ``www-data`` user to the ``helfertool`` group so that
Apache can read the static files.
Possible other solutions are running the complete Apache server as
``helfertool`` or adjusting the file permissions of the static files directory.

Then activate the new vHost and if necessary disable the default vHost.

.. code-block:: none

   sudo a2ensite helfertool.conf
   sudo a2dissite 000-default.conf  # for a new apache installation
   sudo a2enmod rewrite ssl headers
   sudo systemctl restart apache2

Try to access the website, it should work now!

Nginx
-----

Place the configuration in ``/etc/nginx/sites-available/helfertool.conf``,
the file is also in the git repository under ``stuff/deployment/nginx.conf``.
Review and adapt the settings carefully.

.. code-block:: none

   upstream django {
       server 127.0.0.1:3001;
   }

   # HTTP: redirect to HTTPS
   server {
       # server info
       listen 80 default_server;
       listen [::]:80 default_server;

       server_name app.helfertool.org;
       server_tokens off;

       # redirect
       return 301 https://$server_name$request_uri;

       # logging
       access_log /var/log/nginx/helfertool_access.log;
       error_log /var/log/nginx/helfertool_error.log error;
   }

   # HTTPS: serve app
   server {
       # server info
       listen 443 ssl default_server;
       listen [::]:443 ssl default_server;

       server_name app.helfertool.org;
       server_tokens off;

       # TLS settings
       ssl_certificate /etc/ssl/certs/ssl-cert-snakeoil.pem;
       ssl_certificate_key /etc/ssl/private/ssl-cert-snakeoil.key;

       ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
       ssl_ciphers HIGH:!aNULL:!MD5;

       add_header Strict-Transport-Security "max-age=15552000";

       # static files and reverse proxy
       location /static {
           alias /srv/helfertool/helfertool/static;
       }

       location /media {
           alias /srv/helfertool/helfertool/media;
       }

       location / {
           uwsgi_pass django;
           include /etc/nginx/uwsgi_params;
       }

       error_page 502 /static/helfertool/unavailable.html;

       # security options
       add_header X-Content-Type-Options nosniff;
       add_header X-XSS-Protection "1; mode=block";
       add_header Content-Security-Policy "default-src: https: 'unsafe-inline'";

       # logging
       access_log /var/log/nginx/helfertool_access.log;
       error_log /var/log/nginx/helfertool_error.log error;
   }

We have to add the ``www-data`` user to the ``helfertool`` group so that
Nginx can read the static files.
Possible other solutions are running the complete Nginx server as
``helfertool`` or adjusting the file permissions of the static files directory.

Then activate the new vHost and if necessary disable the default vHost.

.. code-block:: none

   sudo ln -s /etc/nginx/sites-available/helfertool.conf /etc/nginx/sites-enabled/helfertool.conf
   sudo rm /etc/nginx/sites-enabled/default
   sudo systemctl restart nginx

Try to access the website, it should work now!
