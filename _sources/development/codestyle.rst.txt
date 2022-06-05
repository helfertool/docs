.. _codestyle:

==========
Code style
==========

black and pre-commit
--------------------

We use `pre-commit <https://pre-commit.com/>`_ to apply the code style via `black <https://black.readthedocs.io/en/stable/>`_
and run `pylint <https://pypi.org/project/pylint//>`_.

Install the pre-commit git hook:

.. code-block:: none

   pre-commit install

Run manually for all files:

.. code-block:: none

   pre-commit run --all-files

SonarQube
---------

We use `SonarQube <https://sonarcloud.io/dashboard?id=helfertool_helfertool>`_ for static code analysis,
the main branch and all pull requests are analyzed automatically.
