=============
Configuration
=============

Template
--------

The template and related settings can be configured under Badge settings > Advanced settings.

Permissions
^^^^^^^^^^^

You should start with the permissions as their names will be required for the template.

The name of the permission is used in the tool, but not for the badge. You can configured different things there (text, icons, etc.).
The LaTeX name is important for the badge.

LaTeX Template
^^^^^^^^^^^^^^

You should download the default template and start customizing it.
The relevant sections are marked with ``CHANGE`` in the LaTeX file.

First, the variables for all permissions must be defined.
If you have permissions with the LaTeX names ``finance`` and ``food``, it looks like this:

.. code:: latex

   % CHANGE: Insert your permissions here
   % If you add a permission with the name "foo" in the tool, you have to add
   % the following two lines with "perm-foo".
   % Remember to update or remove the following two sample permissions if you do
   % not use them.
   %
   \newboolean{badge@perm-finance}
   \define@key{badge}{perm-finance}{\setboolean{badge@perm-finance}{#1}}
   
   \newboolean{badge@perm-food}
   \define@key{badge}{perm-food}{\setboolean{badge@perm-food}{#1}}

You can change the size of the badges:

.. code:: latex

   % CHANGE: Badge size
   % When changing these values you have most likely to update the number of
   % rows and columns in the advanced badge settings.
   %
   \newlength{\badgewidth}
   \setlength{\badgewidth}{8cm}
   \newlength{\badgeheight}
   \setlength{\badgeheight}{5cm}

The front and back of the badge are defined as TikZ picture.
It is recommended to only change the part that is marked in the template.

.. code:: latex

   \newcommand*\badgefront[1][]{%
      ...
      % all coordinates are relative to background (0,0) to (1,1)
      \begin{scope}[shift={(bg.north west)}, x={(bg.north)}, y={(bg.west)}, scale=2]
            %
            % CHANGE: this is the content of the front side of the badge.
            % All coordinates are relative to the badge size:
            % (0, 0) is the top left corner
            % (1, 1) is the bottom right corner
            %

            % name
            \node[draw=none, text width=0.5\badgewidth] at (0.05,0.1) {\Large \badge@firstname\ \badge@surname};

            % job
            \node[text width=0.5\badgewidth] at (0.05,0.5) {\badge@job};
            ...

            %
            % END CHANGE
            %
      \end{scope}

If is recommended to specify a maximum width for all text fields that can be specified by the user.
Otherwise, it is possible that the badge becomes to big which destroys the complete page.

.. code:: latex

   \node[text width=0.5\badgewidth] at (0.05,0.5) {\badge@job};

The permission flags can be used like this (example from back of badge).
Instead of printing text, you of course can also show icons or do anything else in LaTeX.

.. code:: latex

   \ifthenelse{\boolean{badge@perm-food}}
   {
      \node at (0.15,0.35) {Free food};
   }
   {
      \node at (0.15,0.35) {\sout{Free food}};
   }

Further settings for template
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Number of columns/rows on one page:
   This depends on the badge size in the template (``badgewidth`` and ``badgeheight``).
   You probably will notice if these values need to be changed.

Role for coordinators:
   Text for role on badge if the helper is a coordinator (available as ``\badge@role``).

Role for helpers:
   Text for role on badge if the helper is not a coordinator (available as ``\badge@role``).

Language of badges:
   Language that should be used to generate the badges (English or German).

Format for shift on badges:
   The shift is available as ``\badge@shift`` in LaTeX.
   As helpers might have several different shifts, a list might become longer.
   Therefore, there are different ways for format the shift (hours only, include weekday, include date).

Do not use shift names for badges, always print times:
   If enabled, shift names are not used when printing the shifts on the badges.

Badges only for coordinators:
   Badges are only created for coordinators.

Print barcodes on badges to avoid duplicates:
   Each badge has an unique number that can be printed on the badge as barcode.
   The barcode can then be scanned so that the badge is marked as printed and will not be included in future exports.

Roles and designs
-----------------

The configuration of roles and designs is easier as it does not require changes in the LaTeX template.

A default role and design has to be set.
Additionally, it is also possible to set different roles and designs per job or even per helper.

Customize badges of helpers
---------------------------

You can change all details of a badge for any helper (helper > Edit badge):

- Firstname
- Surname
- Job
- Shift
- Role
- Primary job (required if a helper has multiple jobs so that the tool can decide which role/design should be used)
- Role
- Design
- Photo

This can for example be used if the name of a helper is too long for the badge.
