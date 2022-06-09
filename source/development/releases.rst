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

The following describes the steps for a new release series (like ``1.1.x``).
For patch releases of LTS versions, replace the ``dev`` branch with another temporary branch and ``main`` with ``lts/...``.

Rebase the ``dev`` branch to the ``main`` first.
Then, check that the version is correctly set in the following files.
It needs to be the latest version of the ``main`` branch (like ``1.0.2``).

* ``.bumpversion.cfg``
* ``src/version.txt``

A commit of the changes is not necessary.

Then create the new version:

.. code-block:: none
   
   bump2version --allow-dirty major|minor|patch

Check the git log:

* There should be a new commit and tag.
* The commit should only change the version in the two files listed above, nothing else.

Push the branch, but not the tag:

.. code-block:: none

   git push

Create a pull request on Github, so that the final code quality checks are started.

If this is ok, merge the branch and also push the tags:

.. code-block:: none

   git checkout main
   git merge dev
   git push
   git push --tags

Container
---------

The container is built and pushed automatically via Github actions.

In case there are issues, a local build is possible:

.. code-block:: none

   ./scripts/container.sh build

Then run it to see if every services starts, check http://localhost:8000 in your browser:

.. code-block:: none

   ./scripts/container.sh test

If that worked, push the new container:

.. code-block:: none

   ./scripts/container.sh push

Website and documentation
-------------------------

* Write changelog and update tables with releases (:ref:`here <versions>` and :ref:`here <version_history>`)
* Publish news with tag ``update`` on website

Git cleanup
-----------

In the ``dev`` branch, the version in ``src/vesion.txt`` needs to be set to ``dev`` again.
Commit this change to the ``dev`` branch.
