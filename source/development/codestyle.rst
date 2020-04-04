.. _codestyle:

==========
Code style
==========

PEP8 and pylint
---------------

To run `pylint` and a `PEP8` check for all modules, run:

.. code-block:: none

   ./scripts/check-codestyle.sh

The Python libraries from ``src/requirements_dev.txt`` need to be installed for that.

The maximum line length is 120 characters, not 80.

SonarQube
---------

We use `SonarQube <https://sonarcloud.io/dashboard?id=helfertool_helfertool>`_ for static code analysis,
the master branch and all pull requests are analyzed automatically.