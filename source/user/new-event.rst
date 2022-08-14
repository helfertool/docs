.. _new-event:

==================
Create a new event
==================

When creating a new event or editing and existing event there are a lot of
options.

General
-------

Name for URL:
    This is the name used in the URL for the registration.

    Example: if the name for the URL is *testevent* then the registration is
    available under http://app.helfertool.org/testevent.

    .. warning::
        You should not change this value after the registration was opened or you sent a link to someone.

Event name:
    This is the displayed name of the event, you can change it whenever you
    want.

Date:
    Date of the event, that is displayed on the overview page.
    It is also relevant if you move or duplicate the event
    (if you move the event from 1.1. to 2.1. for example, all shifts will be moved by 1 day).

Number of days:
    Displayed on the overview page. No further use.

E-Mail:
    This mail address is used as reply-to address for the confirmation mails.
    Usually some people respond to these mails when they want to contact you.
    So you should make sure that mails sent to this address are read.

    .. note::
        Our experience shows that most mails are sent by helpers to the reply-to address,
        but there are always mails that are sent to the "From" address of the mails.
        So you should make sure that you read these mails, too.

Registration
------------

Registration publicly visible:
    The event is visible publicly.

    .. note::
        The registration over links is possible even when this is not set.

Show number of helpers on registration page:
    Show or hide numbers of registered and requird helpers.

Maximal overlapping of shifts:
    If two shifts overlap more than this value in minutes it is not possible to
    register for both shifts. Leave empty to disable this check.

    For example if two successive shifts overlap by 15 minutes you should set
    15 here. Then a helper can register for both shifts but not for shifts
    with a higher overlap.

Texts
-----

Before registration:
    This text is shown on the registration page on top.

After registration:
    This text is shown after a helper registered on top of the page.

Contact:
    This text if displayed at the bottom of the registration page and other event-specific pages.

    It is recommended to include contact information like a mail address here.

Logos
-----

Logo:
    This image is displayed on top of the registration form.

    Please use a reasonable image size! The image is not scaled down automatically.
    A width of 400 px should be really enough!

Logo for Facebook:
    This image will be shown when a link to the event is posted on Facebook.
    The image size should be 1052 x 548 px, a higher resolution does not bring
    a better result here since Facebook scales the image down.

Requested helper data
---------------------

Helpers have to confirm to be full age:
    There is a checkbox in the registration form for this.
    If users does not confirm it they cannot register.

    .. note::
        This is of course not sufficient from a legal point of view and does not replace the ID check.
        However, it is a nice filter to prevent misunderstandings.

Ask if helper wants to be notified about new events:
    The helper is asked if he wants to receive mails about further events.

Ask for preferred nutrition:
    Ask for preferred nutrition during registration (No preference, vegetarian, vegan, other).

Ask for phone number:
    Ask for phone number during registration.

Ask for T-shirt size:
    Ask for T-shirt size during registration. If enabled, the available sizes can be configured.

Features
--------

Use badge creation:
    Activate the badge creation system, see :ref:`badges`.

Manage gifts and presence for helpers:
    You can manage whether a helper attended their shift, got the T-shirt, the gifts for the shifts and payed caution for that, see :ref:`gifts`.

Manage prerequisites for helpers:
    You can manage different prerequisites for jobs and whether the helpers fulfill these or not, see :ref:`prerequisites`.

Use the inventory functionality:
    Helpers may receive some items like flashlights during their shift,
    you can manage the loan using barcodes on the badges and items.

Collect additional data for COVID-19 contact tracing:
    Helpers must provide their address for contact tracing during registered.
