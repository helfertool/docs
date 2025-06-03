.. _versions:

========
Versions
========

Version numbers
---------------

The Helfertool uses version numbers aligned with `semantic versioning <https://semver.org/>`_.

+---------------+-----------+--------------------------------------------------------------------+
| **X** . Y . Z | Major     | | Breaking changes that require manual intervention during update  |
|               |           | | or remove feautes.                                               |
+---------------+-----------+--------------------------------------------------------------------+
| X . **Y** . Z | Minor     | New features and changes that should not break your workflows      |
+---------------+-----------+--------------------------------------------------------------------+
| X . Y . **Z** | Patch     | Bug and security fixes for the Helfertool                          |
+---------------+-----------+--------------------------------------------------------------------+

Additionally to the Helfertool versions, the Docker containers have a build version that is just
the build date in RFC3339 / ISO8601 format in UTC (e.g. ``2020-04-04T09:11:20+00:00``).

Release series
---------------

Versions with the same major and minor version form a release series, named like ``1.0.x``.
Relase series are used to tag the Docker containers, the patch version of the Helfertool and container
version are not included in the Docker tags.

Every release series contains one or more new features and changes.
New patch versions within one release series then only fix potential issues.
It is recommended to update to the newest version when it is released, as the Docker containers
for older versions are not updated anymore.
They may therefore contain outdated software with vulnerabilities.

Latest release
---------------

+-----------------+--------------------------------------------+------------------+
| Relase series   | Latest release                             | Release date     |
+=================+============================================+==================+
| 3.3.x           | :ref:`3.3.1 <changelog-3-3-1>`             | 2025-06-03       |
+-----------------+--------------------------------------------+------------------+

.. _versions_tags:

Tags
----

The following Docker tags can be used to refer to a certain release series:

* ``latest``: The latest, but (hopefully) stable release
* ``1.0.x``: The latest version in a specific release series
* ``dev``: the current `dev` Git branch (not stable)
