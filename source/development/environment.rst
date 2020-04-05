.. _dev-environment:

=======================
Development environment
=======================

The following documentation explains how to setup the development environment on Linux.
When the Windows Subsystem for Linux is used, it needs to be updated first to a recent Ubuntu version.
Alternatively, you can just use a virtual machine with Linux.

Initial setup
-------------

Get source code
^^^^^^^^^^^^^^^

First, get the source code of the Helfertool.
Please always start your changed from the ``dev`` branch, not from ``master`` (rebasing becomes easier then).

.. code-block:: none

   git clone https://github.com/helfertool/helfertool.git
   cd helfertool
   git checkout dev

Python
^^^^^^

Then, create a Python virtual environment and install all dependencies:

.. code-block:: none

   python3 -m venv venv
   . ./venv/bin/activate

   pip install -r src/requirements.txt -r src/requirements_dev.txt

First run
^^^^^^^^^

Before the first run, the database needs to be created. For development, SQLite is used.
After that, the first user should be created.

.. code-block:: none

   cd src

   python manage.py migrate
   python manage.py createcachetable
   python manage.py loaddata toolsettings

   python manage.py createsuperuser

Then, the development web server can be started:

.. code-block:: none

   python manage.py runserver

Now open http://localhost:8000 in your browser.

Optional: Celery and RabbitMQ
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Depending on the feature you want to work at, RabbitMQ is required and celery needs to be started.
The following features currently make use of Celery:

* Generating badges
* Sending the newsletter
* Receiving and handling incoming mails

An easy way to run RabbitMQ is using Docker:

.. code-block:: none

   docker run -d --rm --hostname helfertool-rabbitmq --name helfertool-rabbitmq -p 127.0.0.1:5672:5672 rabbitmq

Now start Celery:

.. code-block:: none

   cd src  # we need to be in the directory with the manage.py file
   celery -A helfertool worker --loglevel=info -B

The default settings in helfertool.yaml do not need to be changed for this setup.
The celery worker here has the celery beat service included (``-B``).
This is not recommended for production (see `celery documentation <https://docs.celeryproject.org/en/latest/userguide/periodic-tasks.html#starting-the-scheduler>`_)!

If you want to stop the container again, run:

.. code-block:: none

   docker stop helfertool-rabbitmq

And to update the container image, run:

.. code-block:: none

   docker pull rabbitmq

Optional: E-mails
^^^^^^^^^^^^^^^^^

The Helfertool tries to send mails to localhost:25 with the default configuration.

If you work on a feature that sends e-mails, you can start a SMTP debug server with this command:

.. code-block:: none

   python3 -m smtpd -n -c DebuggingServer localhost:1025

Additionally, set the SMTP port to 1025 in ``helfertool.yaml``:

.. code-block:: none

   mail:
       send:
           host: "localhost"
           port: 1025

The advantage of this method compared to the console e-mail backend from Django is, that you also see the mails sent in Celery tasks in the same window.

Optional: Editor
^^^^^^^^^^^^^^^^

In case you do not have a preferred editor or IDE for Python, give `Visual Studio Code <https://code.visualstudio.com/>`_ a try.
It detects the virtual environment automatically and activates it when a new terminal is opened.

Just open the main ``helfertool`` directory as folder and it should work out of the box.

Updating
--------

To update all Python dependencies, run:


.. code-block:: none

   . ./venv/bin/activate
   pip install -U -r src/requirements.txt -r src/requirements_dev.txt
