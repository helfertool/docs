.. _mail:

=============
Mail handling
=============

All mails sent by Helfertool are sent from one configured mail address.
The app can also read the mails that are sent back to this address and process non delivery reports.
If the affected helper can be identified (based on the custom mail header ``X-Helfertool`` containing an ID and the original recipient address),
the failed delivery is displayed in the app.
All other mails can be forwarded to another mail address, so Helfertool filters out non delivery reports for you.

Simple example
--------------

Let's assume you have a mailbox ``helfertool@app.helfertool.org`` that you can access via SMTP and IMAP and that is used to send out mails.
Furthermore you have a mailing list / distribution group ``volunteers@app.helfertool.org`` that is read by your team.

A shortened configuration looks like this:

.. code-block:: none

   mail:
       # Connection to mail server for sending
       send:
           user: "helfertool@app.helfertool.org"
           ...

       # Connection to mail server for receiving
       receive:
           user: "helfertool@app.helfertool.org"
           ...

           # The IMAP folder that should be checked for new mails
           folder: "INBOX"

           # Time between checks (in seconds)
           interval: 300

       # Sender address and display name for all outgoing mails
       sender_address: "helfertool@app.helfertool.org"
       sender_name: "Helfertool"

       # Forward received mails that are not handled automatically to this address (with this display name)
       forward_unhandled_address: "volunteers@app.helfertool.org"
       forward_unhandled_name: "Helfertool"

This means that (almost all) non delivery reports sent to ``helfertool@app.helfertool.org`` are automatically processed and not forwarded to your team.
Any other mail, for example replies by helpers, is forwarded to ``volunteers@app.helfertool.org`` so you can take care of it.

Example with Mailman
--------------------

We use Mailman for our own deployment.
The setup might be a bit more complex than necessary but maybe it helps to understand what is possible.

* ``helfertool@app.helfertool.org`` is a Mailman list and is also used as sender address.
* ``volunteers@app.helfertool.org`` is another Mailman list.
* ``helfertoolservice@app.helfertool.org`` is a mailbox (SMTP + IMAP). It is member of the ``helfertool@app.helfertool.org`` mailing list.

.. code-block:: none

   mail:
       # Connection to mail server for sending
       send:
           user: "helfertoolservice@app.helfertool.org"
           ...

       # Connection to mail server for receiving
       receive:
           user: "helfertoolservice@app.helfertool.org"
           ...

           # The IMAP folder that should be checked for new mails
           folder: "helfertool"

           # Time between checks (in seconds)
           interval: 300

       # Sender address and display name for all outgoing mails
       sender_address: "helfertool@app.helfertool.org"
       sender_name: "Helfertool"

       # Forward received mails that are not handled automatically to this address (with this display name)
       forward_unhandled_address: "volunteers@app.helfertool.org"
       forward_unhandled_name: "Helfertool"

We now have a similar setup as the simple example above, but incoming mails are first handled by Mailman.
Mailman then forwards the mail to the ``helfertoolservice`` mailbox that is monitored by Helfertool.
