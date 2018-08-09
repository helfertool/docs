.. _manual:

===================
Manual installation
===================

Dependencies
------------

.. code-block:: none

   sudo apt install python3 python3-venv rabbitmq-server uwsgi uwsgi-plugin-python3 git texlive-latex-extra texlive-fonts-recommended texlive-lang-german

..
   sudo apt install apache2 libapache2-mod-proxy-uwsgi
   sudo apt install mariadb-server libmysqlclient-dev python3-dev

User
----

The app should run as an own user, so create one.
In this manual the app will be placed in ``/srv/helfertool``, adapt this and the
username to your needs.

.. code-block:: none

   addgroup --system helfertool
   adduser --system --home /srv/helfertool --ingroup helfertool --disabled-password helfertool


Python and app
--------------

All following commands should be executed under the user that was created in
the last step (here ``helfertool``):

.. code-block:: none

   sudo -u helfertool bash

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

uWSGI
-----

Since the Django part is working now, it's time to configure the application
server uWSGI.
The configuration has to be placed in ``/etc/uwsgi/apps-available``, for
example in ``/etc/uwsgi/apps-available/helfertool.ini``.

.. code-block:: none

   [uwsgi]
   plugin          = python35
   set-ph          = basedir=/srv/helfertool
   chdir           = %(basedir)/helfertool
   pythonpath      = %(basedir)/lib/python3.5/site-packages
   wsgi-file       = %(basedir)/helfertool/helfertool/wsgi.py
   stats           = %(basedir)/uwsgistats.socket
   socket          = 127.0.0.1:3001
   workers         = 6
   touch-reload    = %(basedir)/app_reload
   vacuum          = True
   uid             = helfertool
   gid             = helfertool

   smart-attach-daemon = %(basedir)/celery.pid %(basedir)/bin/celery -A helfertool worker -c 2 --pidfile=%(basedir)/celery.pid
   exec-as-user-atexit = kill -HUP $(cat %(basedir)/celery.pid)

The file is also part of the git repository in ``stuff/deployment/uwsgi.conf``.
Adapt the paths, number of workers and if necessary other settings to your
needs.

Then create a symlink in the ``apps-enabled`` directory and restart the
service:

.. code-block:: none

   sudo ln -s /etc/uwsgi/apps-available/helfertool.ini /etc/uwsgi/apps-enabled/helfertool.ini
   sudo systemctl restat uwsgi

If you want, you can check for errors in ``/var/log/uwsgi/app/helfertool.log``.
Otherwise we will notice possible problems soon.

Reverse proxy
-------------

The webserver has to work as reverse proxy in front of uWSGI and also serve
the static files.
The following section describes the setup with Apache and Nginx, but you
could also use tools like HAProxy or Varnish.

Place the configuration in ``/etc/apache2/sites-available/helfertool.conf``,
the file is also in the git repository under ``stuff/deployment/apache.conf``.

Place the configuration in ``/etc/nginx/sites-available/helfertool.conf``,
the file is also in the git repository under ``stuff/deployment/nginx.conf``.

Review and adapt the settings carefully.
