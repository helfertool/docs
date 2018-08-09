.. _preparation:

===========
Preparation
===========

Docker
------

First, install Docker according to the `Docker documentation <https://docs.docker.com/install/linux/docker-ce/debian/>`_.

helfertoolctl repository
------------------------

The `helfertoolctl` package can be installed from the Debian repository https://repo.helfertool.org/debian/:

.. code-block:: none

   sudo apt install apt-transport-https

   echo "deb https://repo.helfertool.org/debian/ stretch main" | sudo tee /etc/apt/sources.list.d/helfertool.list

   sudo apt-key adv --recv-keys FA1023F9F6AC494F

   sudo apt upate
   sudo apt install helfertoolctl


Reverse proxy
-------------

Nginx
^^^^^

.. code-block:: none

   sudo apt install nginx

Apache
^^^^^^

.. code-block:: none

   sudo apt install apache2

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
