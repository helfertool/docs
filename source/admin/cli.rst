.. _cli:

======================
Command line interface
======================

``helfertoolctl`` provides commands to open and close the registration of events:

.. code-block:: none

   helfertoolctl open <url_name>
   helfertoolctl close <url_name>

To open the registration for a event at a specific time, the ``at`` daemon
can be used:

.. code-block:: none

   at '13:55 10/18/2018'
