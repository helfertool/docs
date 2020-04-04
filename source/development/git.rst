.. _git:

============
Git branches
============

Currently, there are the following branches:

* ``master``: Stable releases, every release is tagged. The `latest` container is built from there.
* ``dev``: New features are merged and developed on this branch (probably not that stable)
* ``lts/1.0.x``: Branches for LTS release series

New features are first merged to the ``dev`` branch. When the ``dev`` branch is stable and ready for release,
it is merged to ``master`` and a new Helfertool version is released.
For LTS versions, separate branches exist where fixes can be applied.