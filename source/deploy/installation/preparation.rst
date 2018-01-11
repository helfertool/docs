.. _preparation:

===========
Preparation
===========

Packages
--------

First, all necessary packages have to be installed.
The following package names should work on Ubuntu 16.04 LTS and Debian stretch:

.. code-block:: none

   sudo apt install python3 python3-venv rabbitmq-server uwsgi uwsgi-plugin-python3 npm texlive-base git

Additionally, you need a webserver that acts as reverse proxy and delivers
static files.
Depending on your choice, install Nginx or Apache:

Apache
^^^^^^

.. code-block:: none

   sudo apt install apache2 libapache2-mod-proxy-uwsgi

Nginx
^^^^^

.. warning::
   The documentation for a deployment with Nginx is not finished yet, so you
   have to configure the webserver on your own.

.. code-block:: none

   sudo apt install nginx


Database
--------

MariaDB
^^^^^^^

.. code-block:: none

   sudo apt install mariadb-server libmysqlclient-dev python3-dev

Then create an user and database:

.. code-block:: none

   sudo mysql
   MariaDB [(none)]> CREATE DATABASE helfertool;
   MariaDB [(none)]> CREATE USER helfertool IDENTIFIED BY '<PASSWORD>';
   MariaDB [(none)]> GRANT ALL PRIVILEGES ON helfertool.* TO helfertool;
   MariaDB [(none)]> ALTER DATABASE helfertool CHARACTER SET utf8;

..
   MariaDB [(none)]> CREATE DATABASE helfertool CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

PostgreSQL
^^^^^^^^^^
.. code-block:: none

   sudo apt install postgresql

Then create an user and database:

.. code-block:: none

   sudo -u postgres createuser -P helfertool
   sudo -u postgres createdb -O helfertool helfertool

RabbitMQ
--------

A new user and virtualhost should be created in RabbitMQ, additionally the
default user ``guest`` should be deleted for security reasons.

.. code-block:: none

   sudo rabbitmqctl add_user helfertool <PASSWORD>
   sudo rabbitmqctl add_vhost helfertool
   sudo rabbitmqctl set_permissions -p helfertool helfertool '.*' '.*' '.*'
   sudo rabbitmqctl delete_user guest

User
----

The app should run as an own user, so create one.
In this manual the app will be placed in ``/srv/helfertool``, adapt this and the
username to your needs.

.. code-block:: none

   addgroup --system helfertool
   adduser --system --home /srv/helfertool --ingroup helfertool --disabled-password helfertool
