.. _updates:

=======
Updates
=======

Please have a short look at the
`news section <https://www.helfertool.org/tags/update/>`_ on the website,
changes that may need manual changes or cause problems are announced there.

First, make sure that the ``helfertoolctl`` package is up-to-date (as well as the operating system).
Then update the Docker container and restart the service:

.. code-block:: none

   sudo helfertoolctl download
   sudo systemctl restart helfertool
