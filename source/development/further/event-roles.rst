.. _dev_event_roles:

=================
Event admin roles
=================

The following concept is currently implemented for event admins only, but it is also planned for job admins.

Roles
-----

The admin roles are defined in
`registration/models/adminroles.py <https://github.com/helfertool/helfertool/blob/dev/src/registration/models/adminroles.py>`_.

Accesses
--------

In the views, it is not checked whether an user has a certain role, but a certain access is requested insead.
This has the advantage that roles can be changed more easily later.

The file
`registration/permissions.py <https://github.com/helfertool/helfertool/blob/dev/src/registration/permissions.py>`_
contains the access definitions, role mapping and functions for permission checks.

Checking permissions in views
-----------------------------

The ``has_access`` method can be used to check access to events, jobs and helpers (not shifts, use the job instead):

.. code-block:: none

   from ..permissions import has_access, ACCESS_EVENT_EDIT
   from .utils import nopermission
   
   if not has_access(request.user, event, ACCESS_EVENT_EDIT):
       return nopermission(request)

It can also be checked if the user has access based on the event or any job of the event:

.. code-block:: none

   from registration.permissions import has_access_event_or_job, ACCESS_MAILS_SEND, ACCESS_JOB_SEND_MAILS

   if not has_access_event_or_job(request.user, event, ACCESS_MAILS_SEND, ACCESS_JOB_SEND_MAILS):
       return nopermission(request)

Checking permissions in templates
---------------------------------

Template tags are defined in
`registration/templatetags/permissions.py <https://github.com/helfertool/helfertool/blob/dev/src/registration/templatetags/permissions.py>`_.

RBAC matrix
-----------

This matrix shows which roles allow which type of access:

+-------------------------------------------+-------+------------+------------+-----------+--------+
| Access                                    | Events                                               |
+                                           +-------+------------+------------+-----------+--------+
|                                           | Admin | Restricted | Front desk | Inventory | Badges |
+===========================================+=======+============+============+===========+========+
| ACCESS_INVOLVED                           | x     | x          | x          | x         | x      |
+-------------------------------------------+-------+------------+------------+-----------+--------+
| ACCESS_EVENT_EDIT                         | x     |            |            |           |        |
+-------------------------------------------+-------+------------+------------+-----------+--------+
| ACCESS_EVENT_EDIT_LINKS                   | x     |            |            |           |        |
+-------------------------------------------+-------+------------+------------+-----------+--------+
| ACCESS_EVENT_EDIT_JOBS                    | x     |            |            |           |        |
+-------------------------------------------+-------+------------+------------+-----------+--------+
| ACCESS_EVENT_EXPORT_HELPERS               | x     | x          |            |           |        |
+-------------------------------------------+-------+------------+------------+-----------+--------+
| ACCESS_EVENT_EDIT_DUPLICATES              | x     | x          |            |           |        |
+-------------------------------------------+-------+------------+------------+-----------+--------+
| ACCESS_EVENT_VIEW_COORDINATORS            | x     | x          | x          | x         |        |
+-------------------------------------------+-------+------------+------------+-----------+--------+
| ACCESS_JOB_EDIT                           | x     |            |            |           |        |
+-------------------------------------------+-------+------------+------------+-----------+--------+
| ACCESS_JOB_EDIT_HELPERS                   | x     | x          |            |           |        |
+-------------------------------------------+-------+------------+------------+-----------+--------+
| ACCESS_JOB_VIEW_HELPERS                   | x     | x          | x          | x         |        |
+-------------------------------------------+-------+------------+------------+-----------+--------+
| ACCESS_JOB_SEND_MAILS                     | x     | x          |            |           |        |
+-------------------------------------------+-------+------------+------------+-----------+--------+
| ACCESS_JOB_VIEW_MAILS                     | x     | x          |            |           |        |
+-------------------------------------------+-------+------------+------------+-----------+--------+
| ACCESS_JOB_VIEW_STATISTICS                | x     | x          |            |           |        |
+-------------------------------------------+-------+------------+------------+-----------+--------+
| ACCESS_HELPER_EDIT                        | x     | x          |            |           |        |
+-------------------------------------------+-------+------------+------------+-----------+--------+
| ACCESS_HELPER_VIEW                        | x     | x          | x          | x         |        |
+-------------------------------------------+-------+------------+------------+-----------+--------+
| ACCESS_HELPER_RESEND                      | x     | x          | x          |           |        |
+-------------------------------------------+-------+------------+------------+-----------+--------+
| ACCESS_INVENTORY_EDIT                     | x     |            |            |           |        |
+-------------------------------------------+-------+------------+------------+-----------+--------+
| ACCESS_INVENTORY_HANDLE                   | x     | x          |            | x         |        |
+-------------------------------------------+-------+------------+------------+-----------+--------+
| ACCESS_BADGES_EDIT                        | x     |            |            |           |        |
+-------------------------------------------+-------+------------+------------+-----------+--------+
| ACCESS_BADGES_GENERATE                    | x     | x          |            |           | x      |
+-------------------------------------------+-------+------------+------------+-----------+--------+
| ACCESS_BADGES_EDIT_HELPER                 | x     | x          |            |           |        |
+-------------------------------------------+-------+------------+------------+-----------+--------+
| ACCESS_MAILS_SEND                         | x     | x          |            |           |        |
+-------------------------------------------+-------+------------+------------+-----------+--------+
| ACCESS_MAILS_VIEW                         | x     | x          |            |           |        |
+-------------------------------------------+-------+------------+------------+-----------+--------+
| ACCESS_STATISTICS_VIEW                    | x     | x          |            |           |        |
+-------------------------------------------+-------+------------+------------+-----------+--------+
| ACCESS_GIFTS_EDIT                         | x     |            |            |           |        |
+-------------------------------------------+-------+------------+------------+-----------+--------+
| ACCESS_GIFTS_HANDLE                       | x     | x          | x          |           |        |
+-------------------------------------------+-------+------------+------------+-----------+--------+
| ACCESS_PREREQUISITES_EDIT                 | x     |            |            |           |        |
+-------------------------------------------+-------+------------+------------+-----------+--------+
| ACCESS_PREREQUISITES_VIEW                 | x     | x          |            |           |        |
+-------------------------------------------+-------+------------+------------+-----------+--------+
| ACCESS_PREREQUISITES_HANDLE               | x     | x          |            |           |        |
+-------------------------------------------+-------+------------+------------+-----------+--------+
