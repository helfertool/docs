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

   git clone https://github.com/helfertool/helfertool.git

Than install the Python dependencies:

.. code-block:: none

   pip install -r helfertool/requirements.txt

Depending on your database choice you have to install further packages:

MariaDB
    .. code-block:: none

       pip install mysqlclient

PostgreSQL
    .. note::

       The documentation is not yet complete, sorry!

Bower
-----

Next, we need Bower to install the CSS and JS libraries:

.. code-block:: none

   npm install bower
   # fix so that bower is found inside the virtualenv
   ln -s "$(pwd)/node_modules/bower/bin/bower" "bin/bower"

Try to run bower with the command ``bower``.
If you receive the following error message, you have to create a symlink from
``node`` to ``nodejs``.

.. code-block:: none

   /usr/bin/env: ‘node’: No such file or directory

If necessary, create this symlink:

.. code-block:: none

   sudo ln -s /usr/bin/nodejs /usr/bin/node

.. note::
   Bower is deprecated, so it will be replaced by something else in the future.
   But for now, it does its job.

Now we can install the JS and CSS dependencies:

.. code-block:: none

   cd helfertool
   python manage.py bower install

Basic settings
--------------

After the installation of the dependencies it's time for some basic
configuration.
To make further updates easier, we recommend to switch to a local git branch
for configuration changes:

.. code-block:: none

   git config user.email "admin@localhost"
   git config user.name "Administrator"
   git checkout -b local

The configuration can be found in ``helfertool/settings.py``, so open this file
with your favourite editor.
These are the most important settings, that should be set now:

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

    .. note::

       The documentation is not yet complete, sorry!

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

       ./stuff/bin/gen-secret-key.py

Debug
    Set ``DEBUG`` to ``False``, you should never deploy a Django app with enabled
    debuging!

    .. code-block:: none

       DEBUG = False

Allowed hosts
    When debugging is disabled, we need to set the allowed hostnames under
    which the application is served:

    .. code-block:: none

       ALLOWED_HOSTS = ['app.helfertool.org', 'www.app.helfertool.org']

Make sure that the file is only readable for the ``helfertool`` user since
it contains passwords:

.. code-block:: none

   chmod 0600 helfertool/settings.py

Finally, commit the changes:

.. code-block:: none

   git commit -a -m "Basic configuration"

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
