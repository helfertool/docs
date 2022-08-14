=======
Concept
=======

Badges may be used for access control or to affirm certain priviledges during an event.
They can be created with the tool using a LaTeX template.
It is possible to print barcodes on the badges, then the tool remembers all scanned barcodes and does not export the same badge multiple times.

In order to generate badges, you need to:

* Customize the LaTeX template and template-related settings
* Define roles and designs
* Configure a default role and design
* Maybe configure other roles and design for jobs or single helpers

Let's define the relevant terms first:

Permissions
-----------

Permissions that a helper can have like VIP access, free drinks, etc.
These permissions will be somehow printed on the badge, you can define this in the LaTeX template lateron.
Technically, these are booleans that are passed to the template.

Roles
-----

A collection of permissions that is assigned to jobs or helpers.

Design
------

The design of a badge: text color, background color, background images for front and back of badge.
