.. _changelog:

=========
Changelog
=========

.. _changelog-3-2-3:

3.2.3 (2024-04-09)
------------------

* Security update for Pillow library

.. _changelog-3-2-2:

3.2.2 (2023-10-07)
------------------

* Security update for Pillow library
* Increase upload limit for nginx in container

.. _changelog-3-2-1:

3.2.1 (2023-10-01)
------------------

* Fix validation links (UUID handling)

.. _changelog-3-2-0:

3.2.0 (2023-09-30)
------------------

* Updates of dependencies (Django 4.2, Celery 5, Debian Bookworm for container, ...)
* Fix bug in e-mail hanlding during authentication with OpenID Connect
* Minor UI fixes

.. _changelog-3-1-2:

3.1.2 (2022-10-29)
------------------

* Fix bug in badge creation when number of columns is not 2

.. _changelog-3-1-1:

3.1.1 (2022-09-03)
------------------

* Fixes for updated python libraries
* Pin python libraries in requirements.txt files

.. _changelog-3-1-0:

3.1.0 (2022-07-25)
------------------

* Important bug fix: moving an event sets date of all events to same day
* Improved mail tracking: show delivery errors for events and newsletter
* Language chooser for resending of confirmation mail

.. _changelog-3-0-0:

3.0.0 (2022-06-09)
------------------

Have a look at the :ref:`migration guide <migration-3-0-0>` before the update.

* Breaking change: New container that requires different Docker parameters to run

  * Container is built with Podman now, but Docker still can be used to run it
  * `helfertoolctl` still uses Docker and can run old an new containers

* Different roles for job admins: access to mobile phone numbers can be forbidden
* Additional text field with important notes for jobs that is always displayed during registration
* Users and their permisions for events can be merged by admins
* Validation links in mail contain additional parameter to prevent guessing of the link (not enforced yet, will be enforced in future release)
* Bug fix: Allow whitespaces as alternative badge texts to overwrite generated values
* Bug fix: Add pdflatex parameter to prevent waiting for missing files
* Bug fix: Handle DNS errors in mail connection tests on "Check installation" page
* For development: pre-commit and black are used now

.. _changelog-2-2-1:

2.2.1 (2022-01-06)
------------------

* Fix for breaking change in `Django security update <https://www.djangoproject.com/weblog/2022/jan/04/security-releases/>`_

.. _changelog-1-2-4:

1.2.4 (2022-01-06)
------------------

* Django update and fix for breaking change in `Django security update <https://www.djangoproject.com/weblog/2022/jan/04/security-releases/>`_

.. _changelog-2-2-0:

2.2.0 (2021-11-29)
------------------

* Implement logout at OpenID Connect provider
* Add configuration option for periodical OpenID Connect token validation
* Fix bug: Crop error message from undelivered mails if too long

.. _changelog-2-1-3:

2.1.3 (2021-11-13)
------------------

* Add "2G plus" COVID-19 regulation
* COVID-19 contact tracing information can be changed after registration (if enabled)
* Duplication detection is not based on case-insensitive mail address comparison
* Fix bug: Mixed columns in table of helpers
* Fix bug: Restrict image upload to supported file types (JPG and PNG)
* Fix bug: Event duplication also copies data of disabled features
* Fix bug: Crop error message from undelivered mails if too long

.. _changelog-2-1-2:

2.1.2 (2021-10-10)
------------------

* Add "3G plus" COVID-19 regulation

.. _changelog-2-1-1:

2.1.1 (2021-10-06)
------------------

* Fix crash in event duplication if some features are disabled

.. _changelog-2-1-0:

2.1.0 (2021-10-02)
------------------

* Add feature to collect addresses for COVID-19 contact tracing

.. _changelog-2-0-1:

2.0.1 (2021-08-28)
------------------

* Fixed crash in edit/create event view

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
