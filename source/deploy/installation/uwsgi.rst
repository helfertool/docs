.. _uwsgi:

=====
uWSGI
=====

Since the Django part is working now, it's time to configure the application
server uWSGI.
The configuration has to be placed in ``/etc/uwsgi/apps-available``, for
example in ``/etc/uwsgi/apps-available/helfertool.ini``.

.. code-block:: none

   [uwsgi]
   plugin          = python34
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

If you want, you can check for errors in `/var/log/uwsgi/app/helfertool.log`.
Otherwise we will notice possible problems soon.
