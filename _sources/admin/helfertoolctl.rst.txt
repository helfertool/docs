.. _helfertoolctl:

=============
helfertoolctl
=============

Repositories
------------

There are Debian and CentOS repositories for `helfertoolctl` on https://repo.helfertool.org/.

Debian
^^^^^^

There is a stable repository for Debian Bookworm:

.. code-block:: none

   deb https://repo.helfertool.org/debian/ bookworm main

Additionally, there is a repository for Debian Unstable that may contain a less stable version:

.. code-block:: none

   deb https://repo.helfertool.org/debian/ unstable main

CentOS
^^^^^^

There is a stable and testing repository for CentOS 7, see `repo file <https://repo.helfertool.org/centos7.repo>`_:

.. code-block:: none

   [helfertoolctl-stable]
   name=helfertoolctl stable - $basearch
   baseurl=https://repo.helfertool.org/centos/7/$basearch/stable
   gpgcheck=1
   repo_gpgcheck=1
   gpgkey=https://repo.helfertool.org/gpg.key
   enabled=1
   protect=1

   [helfertoolctl-testing]
   name=helfertoolctl testing - $basearch
   baseurl=https://repo.helfertool.org/centos/7/$basearch/testing
   gpgcheck=1
   repo_gpgcheck=1
   gpgkey=https://repo.helfertool.org/gpg.key
   enabled=0
   protect=1

Basic commands
--------------

Start
^^^^^^

To start the Helfertool service, run:

.. code-block:: none

   sudo systemctl start helfertool

It is also possible to run ``helfertoolctl start``, but usually the systemd service should be used.

Stop
^^^^

To stop the Helfertool service, run:

.. code-block:: none

   sudo systemctl stop helfertool

It is also possible to run ``helfertoolctl stop``, but usually the systemd service should be used.

Reload
^^^^^^

It is possible to reload the configuration file without restarting the Docker container:

.. code-block:: none

   sudo systemctl reload helfertool

``helfertoolctl reload`` is the same here and can also be called.

Updates
^^^^^^^

To download the newest version of Helfertool, run:

.. code-block:: none

   sudo helfertoolctl download

After that, the service needs to be restarted. To check, if a restart is necessary, you can run:

.. code-block:: none

   sudo helfertoolctl needsrestart

Initialize
^^^^^^^^^^

After the installation, the database needs to be filled with some initial data:

.. code-block:: none

   sudo helfertoolctl init

.. warning::

   Only run this once at the beginning!

Create administrator
^^^^^^^^^^^^^^^^^^^^

To create a new administrator account using the command line, run:

.. code-block:: none

   sudo helfertoolctl createadmin

Add example event
^^^^^^^^^^^^^^^^^

In case you want to have a test event with most features enables, you can run:

.. code-block:: none

   sudo helfertoolctl exampledata

Show some statistics
^^^^^^^^^^^^^^^^^^^^

To get the number of events, jobs, shifts and total number of helpers including archived helpers, run:

.. code-block:: none

   sudo helfertoolctl statistics

Commands for automation
-----------------------

Open / close public registration automatically
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

`helfertoolctl` provides commands to open and close the registration of events:

.. code-block:: none

   sudo helfertoolctl open <url_name>
   sudo helfertoolctl close <url_name>

To open the registration for a event at a specific time, the ``at`` daemon
can be used:

.. code-block:: none

   at '13:55 10/18/2022'  # date format is mm/dd/yyyy

Disable old accounts
^^^^^^^^^^^^^^^^^^^^

Inactive accounts can be disabled with the ``disableaccounts`` command. Inactive means that

 * the user did not log in since a specified date or
 * the user never logged in, but the account was created before the specified date.

Accounts from external authentication sources (LDAP) are not changed since the
active flag is synced again from there.

.. code-block:: none

   sudo helfertoolctl disableaccounts [--dry-run] YYYY-MM-DD

Advanced commands
-----------------

Shell access
^^^^^^^^^^^^

To start a shell inside the Docker container, run:

.. code-block:: none

   sudo helfertoolctl shell

Django management command
^^^^^^^^^^^^^^^^^^^^^^^^^

To run some Django management command directly, run:

.. code-block:: none

   sudo helfertoolctl manage [...]

Log file postrotate
^^^^^^^^^^^^^^^^^^^

After the log file was rotated (by logrotate), ``postrotate`` must be executed:

.. code-block:: none

   sudo helfertoolctl postrotate
