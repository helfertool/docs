.. _configuration:

=====================
Configuration options
=====================

The configuration file is in YAML format.
The following documentation describes the settings for a deployment with Docker, but there are also some additional configuration options if Docker is not used.

Announcement
------------

A text line can be displayed on every page of the Helfertool, this is useful to announce downtimes for maintenance.

.. code-block:: none

   announcement: "Maintenance on May 4th from 8 pm to 10 pm."


Language
--------

The language of the Helfertool is usually chosen based on the browser request.
If no language is specified, the default language is used (for example for Facebook link previews).

Available languages:

 * English: ``en``
 * German: ``de``

The default language of the badges can be chosen independently of the overall default language.
The language of the badges can also be changed per event.

The timezone currently can only be set for the whole Helfertool, not per event.

.. code-block:: none

   # Possible values: de, en
   language:
       # Default language if not specified by the browser
       default: "de"

       # Language used for badges
       badges: "de"

       # Timezone
       timezone: "Europe/Berlin"

Database
--------

PostgreSQL
^^^^^^^^^^

.. code-block:: none

   database:
       backend: "postgresql"
       name: "helfertool"
       user: "helfertool"
       password: "<PASSWORD>"
       host: 172.17.0.1
       port: 5432

MySQL / MariaDB
^^^^^^^^^^^^^^^

.. code-block:: none

   database:
       backend: "mysql"
       name: "helfertool"
       user: "helfertool"
       password: "<PASSWORD>"
       host: 172.17.0.1
       port: 3306

SQLite
^^^^^^

.. code-block:: none

   database:
       backend: "sqlite3"
       name: "/data/db.sqlite3"

For Docker deployments, the SQLite file needs to be placed in ``/data``. Otherwise, it is not stored persistently.

Additional database settings
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Django allows to specify additional options like ``init_command``, they can also be added in the Helfertool configuration file:

.. code-block:: none

   database:
       options:
           init_command: "SET sql_mode='STRICT_TRANS_TABLES';"

The `Django documentation <https://docs.djangoproject.com/en/dev/ref/databases/>`_ describes the possible options for the different database backends.

RabbitMQ
--------

.. code-block:: none

   rabbitmq:
       vhost: ""
       user: "guest"
       password: "guest"
       host: 172.17.0.1
       port: 5672

Mail server
-----------

.. code-block:: none

   mail:
       # Connection to mail server for sending
       send:
           host: "localhost"
           port: 25
           user: null
           password: null
           tls: false
           starttls: false

       # Connection to mail server for receiving
       #receive:
       #    host: "localhost"
       #    port: 993
       #    user: "helfertool"
       #    password: "<PASSWORD>"
       #    tls: true
       #    starttls: false
       #
       #    # The IMAP folder that should be checked for new mails
       #    folder: "INBOX"
       #
       #    # Time between checks (in seconds)
       #    interval: 300

       # Sender address and display name for all outgoing mails
       sender_address: "helfertool@localhost"
       sender_name: "Helfertool"

       # Forward received mails that are not handled automatically to this address (with this display name)
       #forward_unhandled_address: "helfertoolintern@localhost"
       #forward_unhandled_name: "Helfertool"

       # Batch size if a high amount of mails is sent
       # This is currently only used for the newsletter, the other mails are sent
       # with all addresses in BCC!
       batch_size: 200
       batch_gap: 5

Authentication
--------------

The Helfertool supports different authentication backends:

 * Local accounts
 * LDAP
 * OpenID Connect

While it is possible to use local accounts together with LDAP or OpenID Connect, it is not recommended to enable LDAP and OpenID Connect at the same time.

LDAP
^^^^

The login to the Helfertool can be restricted to members of a LDAP group.
When ``null`` is specified for the ``login`` option, every user is allowed to login.
If can also be determined based on LDAP group memberships whether an user is administrator or not.
Here, ``null`` means that the admin privilege is not managed by LDAP.

.. code-block:: none

   authentication:
       ldap:
           # Connection details
           server:
               host: "ldaps://ldap.helfertool.org"
               bind_dn: "cn=helfertool,ou=Roles,dc=helfertool,dc=org"
               bind_password: null

           # LDAP schema and attributes
           schema:
               # User definition
               user_dn_template: "uid=%(user)s,ou=People,dc=helfertool,dc=org"
               first_name_attr: "givenName"
               last_name_attr: "sn"
               email_attr: "mail"

               # Group definition
               # See https://django-auth-ldap.readthedocs.io/en/latest/groups.html?highlight=AUTH_LDAP_GROUP_TYPE#types-of-groups
               # for a list of all posible values for group_type
               group_type: "GroupOfNamesType"
               group_base_dn: "ou=Groups,dc=helfertool,dc=org"
               group_object_class: "groupOfNames"

           # Permissions based on groups
           groups:
               login: null
               admin: "cn=admins,ou=Group,dc=helfertool,dc=org"

OpenID Connect
^^^^^^^^^^^^^^

The following claims are required at minimum (the scopes ``openid``, ``email`` and ``profile`` are requested):

 * ``email`` (needs to be unique as it is used as username internally)
 * ``given_name``
 * ``family_name``

The redirect URL for a deployment under ``app.helfertool.org`` whould be : ``https://app.helfertool.org/oidc/callback/`` (``/`` at the end is important).

It can be decided based on claims if an user is allowed to login and if an user is administator.
A claim can be directly compared, for example ``helfertool-login`` has to be ``true`` to allow an user to login.
Alternatively, the claim can be a list and a specific item needs to be in the list.
This can be used when group memberships or roles are written to a claim.

The claim names can be specified with `JMESPath <https://jmespath.org/>`_, so it is possible to configure plain claim names or have a more complex configuration.

If no ``login`` claims restriction is configured, every user is allowed to login.
If the ``admin`` configuration is not present, the admin privilege is not touched during the login and can be assigned manually.

.. warning::

   The logout only ends the session in the Helfertool, not the session at the identity provider.
   A click on login usually logs the user in again without asking for a password.

.. code-block:: none

   authentication:
       # Get users over OpenID Connect
       oidc:
           # Name of the provider (only for login view)
           provider_name: "OpenID Connect"

           # Provider details
           provider:
               # Endpoint URLs
               authorization_endpoint: "http://localhost:8080/auth/realms/test/protocol/openid-connect/auth"
               token_endpoint: "http://localhost:8080/auth/realms/test/protocol/openid-connect/token"
               user_endpoint: "http://localhost:8080/auth/realms/test/protocol/openid-connect/userinfo"

               # URI to get JWKS
               jwks_uri: "http://localhost:8080/auth/realms/test/protocol/openid-connect/certs"

               # Client ID and secret
               client_id: "helfertool"
               client_secret: "<SECRET>"

           # Permissions based on claims
           claims:
               # There are two types to handle claims
               # 1) direct: the claim is directly compared
               # 2) member: the claim is a list and it is checked if the specified value is included (useful for groups/roles)
               # The path is a JMESPath. Plain claim names like "roles" are also a valid JMESPath.
               login:
                   #compare: "direct"
                   #path: "helfertool_login"
                   #value: true
                   compare: "member"
                   path: "roles"
                   value: "helfertool_login"

               admin:
                   #compare: "direct"
                   #path: "helfertool_admin"
                   #value: true
                   compare: "member"
                   path: "roles"
                   value: "helfertool_admin"

.. note::

   JMESPath support was added in version 1.1. For version 1.0, the parameter ``path`` is called ``name`` and directly looked up in the claim.


Local users
^^^^^^^^^^^

When using local users together with LDAP and OpenID Connect, conflicting usernames need to be prevented.
This can be done by prepending a special character in front of local usernames (here: ``@``).

.. code-block:: none

   authentication:
       # Prepend character to all locally created users
       # This is useful if you have for example users from LDAP but also local
       # users. The additional character like '@' is used to prevent identical
       # user names for different users
       local_user_char: '@'

.. note::

   This setting is ignored by the ``createupseruser`` CLI command. The CLI should only be used to create the initial administrator.
   Further administrators should be added in the web interface.

Logging
-------

Error reporting
^^^^^^^^^^^^^^^

If an exception occurs, Django can send out a mail to notify the administrators.
Usually, this means that there is a bug in the Helfertool, a configuration error or some infrastructure issue.

.. code-block:: none

   logging:
       # Sent mails on internal server errors
       mails:
           - root@localhost

Syslog
^^^^^^

The application log can be sent out via syslog (see :ref:`logging` for available events).

When using the Docker container and `helfertoolctl`, the application log is written to the log directory ``/var/log/helfertool``.
The syslog forwarding can be used additionally.


.. code-block:: none

   logging:
       syslog:
           # Log level that will be sent to syslog: INFO, WARNING, ERROR
           level: 'INFO'

           # Server, port and protocol
           # UDP is recommended. With TCP, the syslog server needs to run and accept connections when the Helfertool is started.
           server: 'localhost'
           port: 514
           protocol: 'udp'

           # Syslog facility to use
           facility: 'local7'

.. _configuration-logging-database:

Database
^^^^^^^^

.. note::

   This feature is available since version 1.2.


The log entries, which belong to an event, are additionally stored in the database and can be viewed by event admins.
Other log entries like logins or password changes, which do not belong to a particular event,
are not stored in the database (see previous section for syslog and log files).

The stored log entries are deleted when an event is archived.

The database logging can be disabled:

.. code-block:: none

   # Store all event-related events in the database.
   # The log entries are only stored as long as the event exists and are deleted with the event.
   #database: true

Security settings
-----------------

.. warning::

   Never set ``debug`` to ``true`` in production!

.. code-block:: none

   security:
       # Do not activate debugging in productive environments!
       debug: false

       # Unique and secret key
       secret: "change_this_for_production"

       # URLs that are used for the software
       allowed_hosts:
       #    - "app.helfertool.org"
       #    - "www.app.helfertool.org"

       # Account lockout
       lockout:
           # Number of failed login attempts until lockout
           limit: 3

           # Lockout duration in minutes
           time: 10

       # Minimal password length (for local accounts)
       password_length: 12

.. _configuration-features:

Features
--------

.. note::

   These configuration options are available since version 1.2.

Helfertool features can be disabled globally which means that the feature cannot be enabled at all.

If a flag is changed to disabled, all events are modified automatically after a reload (note for custom installations: this requires Celery).
Enabling a feature does not change event settings.

.. code-block:: none

   features:
       # Collect mail addresses for newsletter.
       # This also disables the unsubscribe link. If the feature was used previously and is now disabled,
       # you should take care of the stored data (greetings from GDPR)
       newsletter: true
   
       # Further features
       badges: true
       gifts: true
       prerequisites: true
       inventory: true

Customization
-------------

.. code-block:: none

   customization:
       # Modify certain properties for the general helfertool to display
       display:
           # Maximum years of events to be displayed by default on the main page
           events_last_years: 2

       # Fuzzy search for helper names
       # Only available on PostgrSQL with pg_trgm extension, disabled automatically otherwise
       search:
           # Values between 0.2 (show more results) and 0.5 (show less results) seem to be reasonable.
           # The similarity threshold of 0.3 was selected based on a name database of ~4000 western
           # european names and the gut feel when a good match was actually found.
           similarity: 0.3

           # If PostgreSQL is used and pg_trgm is installed, the similarity search is automatically used.
           # If you do not want to have this, disable it here.
           disable_similarity: false

       # There are some external links that should/can be changed
       urls:
           # Imprint with contact details
           imprint: "https://app.helfertool.org/impressum/"

           # Privacy statement
           privacy: "https://app.helfertool.org/datenschutz/"

           # Link to documentation (usually no change necessary)
           docs: "https://docs.helfertool.org"

       # Contact address for support requests
       contact_address: "helfertool@localhost"

Badge settings
--------------

.. code-block:: none

   badges:
       # Alternative default template, path to tex file
       # Relative paths again are relative to the git directory
       template: "src/badges/latextemplate/badge.tex"

       # Maximum photo size in kb
       photo_max_size: 1000

       # Maximum number of copies for special badges
       special_badges_max: 50

       # Time until PDF file is deleted after it was created in minutes
       pdf_timeout: 30

       # Time until files are really deleted after cleanup was triggered
       # in minutes
       rm_delay: 2

Additional settings without Docker
----------------------------------

If Docker is not used, some additional settings may be interesting:

.. code-block:: none

   # Location of uploaded files, static files and temporary files.
   # Relative paths are relative to the git directory, absolute paths
   # are also possible.
   files:
       static: "static"
       media: "media"
       tmp: "/tmp"

   security:
       # Application is behind additional/second proxy. In this case, the HTTP
       # header X-Forwarded-Host is used. Example: Apache > nginx > uwsgi
       behind_proxy: False

   badges:
       # Path to pdflatex binary
       pdflatex: "/usr/bin/pdflatex"

   # Deployed in docker image?
   docker: false
