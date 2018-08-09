==========
Deployment
==========

The Helfertool should run on most current Linux distributions, but is mostly
used on Debian at the moment.

The most easy way to deploy the Helfertool is using Docker and the
`helfertoolctl` Debian package. Of course, you can also use the Docker
container on other systems, but the `helfertoolctl` package provides a wrapper
script around Docker and useful things like a systemd service file. Beside that,
it is also possible - but not recommended - to deploy the Helfertool manually
as a usual Django application.

The following documentation only explains the setup on Debian systems with
Docker and `helfertoolctl` in detail. Please feel free to submit corrections
and additions.

.. toctree::
   :maxdepth: 1

   dependencies
   preparation
   installation
   configuration
   validating
   updating
   other/index
