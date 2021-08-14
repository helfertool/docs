.. _changelog:

=========
Changelog
=========

.. _changelog-2-0-0:

2.0.0 (2021-08-14)
------------------

Have a look at the :ref:`migration guide <migration-2-0-0>` before the update.

* Breaking change: e-mail validation after registration cannot be disabled anymore (see next item)
* Breaking change: Double opt-in for newsletter subscription

  * Subscription without event registration: separate e-mail
  * Subscription during event registration: link in confirmation mail (therefore, it cannot be disabled anymore)
  * New setting for text, that is displayed on subscribe page

* Breaking change: Improved access control for media files

  * Uploaded files are now separated into `public` and `private` files
  * One-time migration after update via managemet command necessary

* New fully responsive web design and inclusive language (German)
* More detailed nutrition options and views (no preference, vegetarian, vegan, other)
* Add configuration option to set `SameSite` attribute to `Lax`, which is necessary if OpenID Connect provider
  is hosted on other domain (`oidc` > `provider` > `thirdparty_domain`)
* Add form to delete users
* Default account lockout limit is increased to 5
* Bug fix: mail receiving now handles missing `To` and `From` headers
* Bug fix: status of IMAP connection now displayed on status page
* Bug fix: certain shifts were displayed on wrong day due to timezone bug
* Bug fix: administrators, which were configured via the admin interface, can access the Django admin interface now
* Bug fix: block certain event URL names that collide with other URLs (like `subscribe`)
* Updated HTTP security and caching headers (Only relevant if you do not use the Docker container. In this case, check the diffs in the nginx config)

.. _changelog-1-2-3:

1.2.3 (2021-05-13)
------------------

* Fix bug in event handler for failed logins (event was not created successfully)

.. _changelog-1-2-2:

1.2.2 (2021-05-11)
------------------

* Update chart.js due to CVE-2020-7746 (but no risk for Helfertool)

.. _changelog-1-2-1:

1.2.1 (2021-01-12)
------------------

* Fixed bug in event permission system (crash due to typo)

.. _changelog-1-2-0:

1.2.0 (2021-01-10)
------------------

* Helfertool features like badges can be disabled globally (see :ref:`here <configuration-features>`)
* Introduce special badges which are not associated with helpers and numbered serially, for example: Police 1, Police 2, etc.
* Badge barcode numbers start at 1000 (for existing events, there will be a gap of 1000 in the numbers)
* Shifts can be printed on badges (a list of all shifts is generated, there are different format options)
* When merging duplicated helpers, selected helpers can be ignored and kept as duplicates
* T-Shirt statistics are kept when event if archived (only total numbers, not per job)
* Admin view for past events which are not archived added
* Audit log for events is stored in database and can be viewed in web interface (can be disabled, see :ref:`here <configuration-logging-database>`)
* Removed ``X-Real-IP`` header from "Check installation" page as it is not used and added remote IP instead.
* Set ``HttpOnly`` and ``Secure`` flags for language cookie (was already set for session and CSRF cookies)
* Updated `example nginx config <https://github.com/helfertool/helfertool/blob/v1.2.0/deployment/proxy/nginx.conf>`_ (enabled TLS1.3, updated X- headers)

.. _changelog-1-1-0:

1.1.0 (2020-08-15)
------------------

* Overlapping shifts are greyed out and disabled on registration page
* Different admin roles for events are available (see :ref:`here <access-control>`)
* Presence of helpers can be set automatically when shift starts (i.e. present if not noted otherwise)
* Presence of helpers integrates better with helper gifts
* Prerequisites for helpers can be managed (for example attendance at a training)
* Internal comment field for helpers added
* Events can be moved to other date (which updates all shift dates)
* Added list of vacant shifts per day
* Hide old events on main page after some years (can be changed in configuration)
* Similarity based search for names (PostgreSQL only, see :ref:`installation <installation>`)
* OpenID Connect claims can be matched using JMESPath
* Add management command `exampledata` to add a test event during development
* Bug fix: wrong day set when duplicating shifts starting at 0:00
* Bug fix: inventory settings were not copied when duplicating an event
* Bug fix: handle OpenID Connect like LDAP on user account pages
* Bug fix: management command for statistics crashed if no archived helpers exist

.. _changelog-1-0-2:

1.0.2 (2020-06-13)
------------------

* Updated jQuery

.. _changelog-1-0-1:

1.0.1 (2020-05-31)
------------------

* OpenID Connect: Allow usage of id_token for claim validation

.. _changelog-1-0-0:

1.0.0 (2020-04-04)
------------------

* First release with version numbers
* Release "1.0" does not mean anything special, but we have to start counting somewhere.
