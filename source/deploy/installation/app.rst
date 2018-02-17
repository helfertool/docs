.. _app:

===
App
===

All following commands should be executed under the user that was created in
the last step (here ``helfertool``):

.. code-block:: none

   sudo -u helfertool bash

Python and app
--------------

First, create the virtual environment and activate it:

.. code-block:: none

   pyvenv .
   . ./bin/activate

Now get the source code:

.. code-block:: none

   git clone --depth 1 https://github.com/helfertool/helfertool.git

Than install the Python dependencies:

.. code-block:: none

   pip install -r helfertool/requirements.txt

Depending on your database choice you have to install further packages:

MariaDB
    .. code-block:: none

       pip install mysqlclient

PostgreSQL
    .. code-block:: none

       pip install psycopg2-binary

Basic settings
--------------

After the installation of the dependencies it's time for some basic
configuration.

The local configuration has to be places in
``helfertool/helfertool/settings_local.py``,
so create this file from the template:

.. code-block:: none

   cp helfertool/helfertool/settings_local.dist.py helfertool/helfertool/settings_local.py

Open the file ``helfertool/helfertool/settings_local.py`` with your favourite
editor. These are the most important settings, that should be set now:

Database
    For MariaDB use this configuration:

    .. code-block:: none

       DATABASES = {
           'default': {
               'ENGINE': 'django.db.backends.mysql',
               'NAME': 'helfertool',
               'USER': 'helfertool',
               'PASSWORD': '<PASSWORD>',
               'HOST': '127.0.0.1',
               'PORT': '',
               'OPTIONS': {
                   "init_command": "SET sql_mode='STRICT_TRANS_TABLES';",
               }
           }
       }

    For PostgreSQL use this configration:

    .. code-block:: none

       DATABASES = {
           'default': {
               'ENGINE': 'django.db.backends.postgresql',
               'NAME': 'helfertool',
               'USER': 'helfertool',
               'PASSWORD': '<PASSWORD>',
               'HOST': '127.0.0.1',
               'PORT': '5432',
           }
       }

RabbitMQ
    The connection to RabbitMQ has also to be configured:

    .. code-block:: none

       CELERY_BROKER_URL = 'amqp://helfertool:<PASSWORD>@localhost:5672/helfertool'
       CELERY_RESULT_BACKEND = 'amqp://helfertool:<PASSWORD>@localhost:5672/helfertool'

Secret key
    This has to be an unique and secret key.

    .. code-block:: none

       SECRET_KEY = 'CHANGE-ME-AFTER-INSTALL'

    You can generate one with this command:

    .. code-block:: none

       ./helfertool/stuff/bin/gen-secret-key.py

Debug
    Set ``DEBUG`` to ``False``, you should never deploy a Django app with enabled
    debugging!

    .. code-block:: none

       DEBUG = False

Allowed hosts
    When debugging is disabled, we need to set the allowed hostnames under
    which the application is served:

    .. code-block:: none

       ALLOWED_HOSTS = ['app.helfertool.org', 'www.app.helfertool.org']

Make sure that the file is only readable for the user ``helfertool`` since
it contains passwords:

.. code-block:: none

   chmod 0600 helfertool/helfertool/settings_local.py

Migrations, static files and user creation
------------------------------------------

To setup the database, the following command has to be executed:

.. code-block:: none

   python manage.py migrate

The following command collects all static files in one directory that will
be delivered by the webserver later:

.. code-block:: none

   python manage.py collectstatic

Now we can also create the first user:

.. code-block:: none

   python manage.py createsuperuser

Testing
-------

Finally, we can run the development webserver to validate the installation:

.. code-block:: none

   python manage.py runserver

Stop the server again with ``Ctrl + C`` (it is not suitable for productive
deployment).

We can also check the connection to RabbitMQ by starting the some workers:

.. code-block:: none

   celery -A helfertool worker -c 2 --loglevel=info
