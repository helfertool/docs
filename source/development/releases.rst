.. _releases:

===============
Making releases
===============

Preparation
-----------

* Check that all migrations are created (``makemigrations``).
* Check that all translations are done.
* Check for changes in ``helfertool.yaml``: update docs and ``helfertoolctl``

Git
---

On the ``master`` branch, run:

.. code-block:: none
   
   bump2version major|minor|patch

After checking the git log, push it:

.. code-block:: none

   git push
   git push --tags

Docker
------

The, the Docker container need to be build, tested and pushed:

First, build the container from scratch:

.. code-block:: none

   ./scripts/docker.sh build

Then run it to see if every services starts, check http://localhost:8000 in your browser:

.. code-block:: none

   ./scripts/docker.sh test

If that worked, push the new container:

.. code-block:: none

   ./script/docker.sh push
