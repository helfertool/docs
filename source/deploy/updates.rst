.. _updates:

=======
Updates
=======

This are the steps that are necessary to update Helfertool:

.. code-block:: none

   # enter virtual env
   cd /srv/helfertool
   . ./bin/activate
   cd helfertool

   # update source code
   git pull

   # review for new config options
   diff helfertool/settings_local.dist.py helfertool/settings_local.py

   # update dependencies
   pip install -r requirements.txt
   python manage.py bower install

   # install migrations
   python manage.py migrate

   # update static files
   python manage.py collectstatic --noinput

   # reload app server
   cd ..
   touch app_reload

Additionally, you should update the Python libraries from time to time,
`pip-review <https://github.com/jgonggrijp/pip-review>`_ is a good tool for
that.
