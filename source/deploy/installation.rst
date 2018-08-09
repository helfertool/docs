.. _installation:

============
Installation
============

Container download
------------------

.. code-block:: none

   sudo helfertoolctl download

Basic configuration
-------------------

.. note::
   This section is missing, sorry!

First start
-----------

.. note::
   This section is missing, sorry!

Reverse proxy
-------------

The webserver works as reverse proxy in front of the Docker container and
terminates the TLS connection.
The following section describes the setup with Apache and Nginx, but you
could also use tools like HAProxy or Varnish.

Nginx
^^^^^

Place the configuration in ``/etc/nginx/sites-available/helfertool.conf``.

..
  the file is also in the git repository under ``stuff/deployment/nginx.conf``.
  Review and adapt the settings carefully.

.. note::
   This configuration example is missing, sorry!

Then activate the new vHost and if necessary disable the default vHost.

.. code-block:: none

   sudo ln -s /etc/nginx/sites-available/helfertool.conf /etc/nginx/sites-enabled/helfertool.conf
   sudo rm /etc/nginx/sites-enabled/default
   sudo systemctl restart nginx

Try to access the website, it should work now!

Apache
^^^^^^

Place the configuration in ``/etc/apache2/sites-available/helfertool.conf``.

..
  the file is also in the git repository under ``stuff/deployment/apache.conf``.
  Review and adapt the settings carefully.

.. note::
   This configuration example is missing, sorry!

Then activate the new vHost and if necessary disable the default vHost.

.. code-block:: none

   sudo a2ensite helfertool.conf
   sudo a2dissite 000-default.conf  # for a new apache installation
   sudo a2enmod rewrite ssl headers
   sudo systemctl restart apache2

Try to access the website, it should work now!
