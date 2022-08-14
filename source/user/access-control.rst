.. _access-control:

==============================
Permissions and access control
==============================

Event
-----

.. note::

   The different admin roles on event level were introduced in version 1.1.

There are different admin roles for an event:

Administrator
^^^^^^^^^^^^^

Can do everything with the event, including deletion and permissions changes.

Restricted administrator
^^^^^^^^^^^^^^^^^^^^^^^^

Can manage helpers and all related features, but not change the event settings. The user can not:

* Edit or delete the event itself
* Create or change links
* Change jobs or shifts
* Change inventory, badges, gifts or prerequisite settings
* Access data for COVID-19 contact tracing
* View the audit log

Front desk
^^^^^^^^^^

Can read all helper data, resend the confirmation mail, edit the internal comment and change the delivered
gifts of the helpers. The user cannot change the presence or any other data.

Inventory
^^^^^^^^^

Can read all helper data and register or take back inventory items.

Badges
^^^^^^

Can print and register badges.


Jobs
----

.. note::

   The different roles on job level were introduced in version 3.0.

When editing an job you can add the so called *job admins*. These users can
see and edit the helpers for a specific job. Here is a list of things they
can or cannot do in general:

Can do:

- View the number of helpers for all jobs and shifts
- Add helpers to their job, also before the registration is open
- Edit or delete helpers of their job
- Search helpers (will list also helpers of other jobs, only the name is visible)
- View the names, phone numbers and mail addresses of all coordinators of the event
- Send mails to the helpers and coordinators of their job
- View the T-shirt statistic of their job

Cannot do:

- Edit the event
- Edit the job and shifts (e.g. change the number of helpers)
- Create links
- View the helpers of other jobs
- Send mails to all helpers of the event
- View the total number of helpers
- Anything with badges

There are different roles that differ in the access to the data of the helpers:

Full access to all data
^^^^^^^^^^^^^^^^^^^^^^^

Can access all personal data of the helpers.

Default access
^^^^^^^^^^^^^^

Can access the personal data of the helpers except of:
- Mobile phone number

Global permissions
-------------------

An user can have the permission to create new events, add new users or sent a newsletter.
User can see whether they have some of these permissions or not.

Inventory
---------

Inventories can only be created by Helfertool administrators, but every inventory can have its own administrators.
These can edit the items of an inventory.
