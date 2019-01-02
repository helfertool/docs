.. _helfertoolctl:

=============
helfertoolctl
=============

Repositories
------------

There are Debian and CentOS repositories for `helfertoolctl` on https://repo.helfertool.org/.

Debian
^^^^^^

There is a stable repository for Debian Stretch:

.. code-block:: none

   deb https://repo.helfertool.org/debian/ stretch main

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

Command line interface
----------------------

``helfertoolctl`` provides commands to open and close the registration of events:

.. code-block:: none

   helfertoolctl open <url_name>
   helfertoolctl close <url_name>

To open the registration for a event at a specific time, the ``at`` daemon
can be used:

.. code-block:: none

   at '13:55 10/18/2018'
