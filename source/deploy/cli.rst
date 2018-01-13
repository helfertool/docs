.. _cli:

======================
Command line interface
======================

In addition to the CLI of Djano Helfertool provides additionally these
commands:

openregistration
----------------

.. code-block:: none

   python manage.py openregistration test

``test`` is the URL name.

closeregistration
-----------------

.. code-block:: none

   python manage.py closeregistration test

``test`` is the URL name.

Using ``at`` to open the registration
-------------------------------------

To open the registration for a event at a specific time, the ``at`` daemon
can be used:

.. code-block:: none

   at '13:55 10/18/2018'

If you use a virtualenv you need a script like
``stuff/bin/open-registration.sh``.
