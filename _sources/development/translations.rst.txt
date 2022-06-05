.. _translations:

============
Translations
============

Django requires the `GNU gettext` toolset to be installed.
On Debian for example, it can be isntalled with the ``gettext`` package.

To update the translations, first run:

.. code-block:: none

   cd src
   ./makemessages.sh

Then the new translations can be written to the ``.po`` files.
While this is of course possible with a text editor, we recommend a graphical
tool like `Poedit <https://poedit.net/download>`_.

Afer that, the new ``.mo`` files need to be built:

.. code-block:: none

   python manage.py compilemessages
