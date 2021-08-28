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
Additionally, there is a separate Git branch for every release series
(but this is not important if you just want to use the Docker containers).

Every release series contains one or more new features and changes.
New patch versions within one release series then only fix potential issues.
It is recommended to update to the newest version when it is released, as the Docker containers
for older versions are not updated anymore.
They may therefore contain outdated software with vulnerabilities.

If you do not want to update the Helfertool itself that often, there is a `long term support` release series.
For those Helfertool versions, the Docker container is still rebuilt for a longer time.
In case a critical bug or security vulnerability is found in the Helfertool, it will also be fixed.
Nevertheless, you should always use the latest release of this release series.
Please note that `helfertoolctl` ships the configuration for the latest release which may be incompatibel
with the LTS version.

Supported releases
------------------

+-----------------+--------------------------------------------+------------------+------------------+
| Relase series   | Latest release                             | Release date     | End of life      |
+=================+============================================+==================+==================+
| 2.0.x           | :ref:`2.0.1 <changelog-2-0-1>`             | 2021-08-14       |                  |
+-----------------+--------------------------------------------+------------------+------------------+
| 1.2.x           | :ref:`1.2.3 <changelog-1-2-3>` (LTS)       | 2021-01-10       | 2022-05-01       |
+-----------------+--------------------------------------------+------------------+------------------+

For non-LTS versions, the support ends with the next release.
There is no planned release schedule.

.. _versions_tags:

Tags
----

The following Docker tags can be used to refer to a certain release series:

* ``latest``: The latest, but (hopefully) stable release. This is the default and recommended, unless you want to use the LTS version.
* ``1.0.x``: The latest version in a specific release series. Use this for LTS versions.
* ``dev``: the current `dev` Git branch (not stable)
