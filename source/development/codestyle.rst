.. _codestyle:

==========
Code style
==========

PEP8 and pylint
---------------

`pylint` and `PEP8` checks are automatically done for all pull requests.
You can also run these checks on your machine:

.. code-block:: none

   ./scripts/check-codestyle.py

The Python libraries from ``src/requirements_dev.txt`` need to be installed for that.

it is also possible to check a single app only to save some time:

.. code-block:: none

   ./scripts/check-codestyle.py --module registration

The maximum line length is 120 characters, not 80.

SonarQube
---------

We use `SonarQube <https://sonarcloud.io/dashboard?id=helfertool_helfertool>`_ for static code analysis,
the main branch and all pull requests are analyzed automatically.
