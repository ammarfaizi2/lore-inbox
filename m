Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932265AbWBFScV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbWBFScV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 13:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbWBFScU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 13:32:20 -0500
Received: from mx.laposte.net ([81.255.54.11]:47281 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id S932265AbWBFScT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 13:32:19 -0500
Subject: Re: Linux drivers management
From: Nicolas Mailhot <nicolas.mailhot@laposte.net>
To: David Chow <davidchow@shaolinmicro.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-/RXdf3yEbKmqU74ozmL7"
Organization: Adresse perso
Date: Mon, 06 Feb 2006 19:31:52 +0100
Message-Id: <1139250712.20009.20.camel@rousalka.dyndns.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 (2.5.90-1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/RXdf3yEbKmqU74ozmL7
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> I think I am in a different position like you guys, I've been work with=20
> Linux from programmer level to Linux promotion . My goal is not just=20
> focus on Linux technical or programming, I would like to promote this=20
> operating system to not just for programmers, but also non-technical=20
> end-users .

Since you invoke end-users I'll answer.

This end-user is mad at hell at people like you that advocate separating
drivers from mainline.

Do you really think us end-users enjoy hunting your drivers all over the
net because you never bothered pushing them to mainline ?

Do you really think we enjoy clicking though boatloads of HTML/js/flash
forms that will inform us about vastly important things like your custom
license, the mirror list you want us to master or your dog's birthday ?

Do you really think we enjoy learning all your out-of-tree driver
release and build processes because you couldn't be bothered with using
the same one as the kernel ?

Do you really think we enjoy locating the patch that will "fix" your
driver for our kernel because you do not bother testing anything else
than a few kernel releases, and that only for a few months after a you
wrote your driver ?

Do you really think we enjoy having out out-of-tree drivers stomp on
each-other in their eagerness to downgrade parts our working kernel to
whatever broken and obsolete version the developer happened to test ?

Do you really think we enjoy navigating support forums to find out who's
responsible for the mess ?

Do you really think we enjoy leaving in fear of a system update because
the first thing to break will be your out-of-tree drivers ?

When a driver is part of mainline it'll be in the distro kernel. It'll
be autosetup by distro tools. It'll be auto-updated by system tools. Me
the end user won't even have to know there is a driver involved -
everything will "just work".

Be honest and invoke developer laziness if you want. Invoke the utter
lack of interest of some developers in packaging or making their stuff
working on anything but their own box. Invoke their fear of a thorough
review process. Point out that they are paid to deliver a pile of code
by companies that care little if it's used or not. There are loads of
actual (bad) reasons for your demand.

But do not invoke end-users. Or end users will answer you.

--=20
Nicolas Mailhot

--=-/RXdf3yEbKmqU74ozmL7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iEYEABECAAYFAkPnlhgACgkQI2bVKDsp8g1L5ACg5TEMzPC2Om91QNCC2dR0AX6N
JXMAoI52GwIOsUhO8IFQQx3KnPi7Xra8
=X3Xm
-----END PGP SIGNATURE-----

--=-/RXdf3yEbKmqU74ozmL7--

