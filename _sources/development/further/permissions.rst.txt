.. _dev_permissions:

==================
Global permissions
==================

.. note::

   The different admin roles on event level are currently only available on the ``dev`` branch.

There are different types of permission assignments:

* Global permissions: e.g. adding events
* Per event: different administrative roles and job admins
* Inventory: an inventory can have admins that can edit the items

The following sections explain how the permission checks are implemented.

Global permissions
------------------

The global permissions are managed via group memberships in the following groups:

* registration_addevent
* registration_adduser
* registration_sendnews

The frontend management is implemented in the ``acccounts`` app.
This app also providers different template tags for permission checks in ``globalpermissions.py``.
The functions can also be used in views.

Event
-----

There are different administrative roles for events, which are documented in the :ref:`user documentation <access-control>`.
The implementation details are documented on a :ref:`separate page <dev_event_roles>`.

Inventory
---------

The ``Inventory`` class has just a list of admin users.