===========
Admin guide
===========

The Helfertool should run on most current Linux distributions, but is mostly
used on Debian at the moment.

The most easy way to deploy the Helfertool is using Docker and the
`helfertoolctl` package which is available for Debian.
Of course, you can also use the Docker container on other systems,
but the `helfertoolctl` package provides a wrapper
script around Docker and useful things like a systemd service file. Beside that,
it is also possible to deploy the Helfertool manually as a usual Django application.

To deploy the Helfertool to an own server, a few dependencies are necessary:

 * Docker Engine
 * Database: PostgreSQL (recommended), MySQL, MariaDB or SQLite
 * RabbitMQ
 * Reverse proxy: nginx (recommended), Apache or other suitable software
 * Mail server to send out mails

The following documentation only explains the setup on Debian with Docker
and `helfertoolctl` in detail.

Please feel free to submit corrections and additions.

.. toctree::
   :maxdepth: 1

   versions
   installation
   configuration
   updates
   helfertoolctl
   further/index
   migration/index
