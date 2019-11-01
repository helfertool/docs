.. _configuration:

=====================
Configuration options
=====================

The configuration file is in YAML format.
The following documentation describes the settings for a deployment with Docker, but there are also some additional configuration options if Docker is not used.

Language
--------

.. code-block:: none

   # Language settings
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

For Docker deployments, the file needs to be placed in `/data`. Otherwise, it is not stored persistently.

Additional database settings
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Addtional options like `init_command` can also be added:

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
       #forward_unhandled_address: "helfertool@localhost"
       #forward_unhandled_name: "Helfertool"

       # Batch size if a high amount of mails is sent
       # This is currently only used for the newsletter, the other mails are sent
       # with all addresses in BCC!
       batch_size: 200
       batch_gap: 5

LDAP
----

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

       # Prepend character to all locally created users
       # This is useful if you have for example users from LDAP but also local
       # users. The additional character like '@' is used to prevent identical
       # user names for different users
       local_user_char: '@'

Logging
-------

Error reporting
^^^^^^^^^^^^^^^

If an exception occurs, Django can send out a mail to notify the administrators.
Usually, this means that there is a bug in the Helfertool.

.. code-block:: none

   logging:
       # Sent mails on internal server errors
       mails:
           - root@localhost

Syslog
^^^^^^
.. code-block:: none

   logging:
       syslog:
           # Log level that will be sent to syslog: INFO, WARNING, ERROR
           level: 'INFO'

           # Server and port
           server: 'localhost'
           port: 514

           # Syslog facility to use
           facility: 'local7'

Security settings
-----------------

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

Customization
-------------

.. code-block:: none

   customization:
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
