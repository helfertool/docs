.. _git:

============
Git branches
============

Currently, there are the following branches:

* ``main``: Stable releases, every release is tagged. The `latest` container is built from there.
* ``dev``: New features are merged and developed on this branch (probably not that stable)

New features are first merged to the ``dev`` branch. When the ``dev`` branch is stable and ready for release,
it is merged to ``main`` and a new Helfertool version is released.
