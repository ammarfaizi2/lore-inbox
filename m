Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262086AbTJANGi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 09:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262092AbTJANGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 09:06:38 -0400
Received: from smtp1.clb.oleane.net ([213.56.31.17]:43711 "EHLO
	smtp1.clb.oleane.net") by vger.kernel.org with ESMTP
	id S262086AbTJANGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 09:06:36 -0400
Subject: Re: Keyboard oddness.
From: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
To: Pavel Machek <pavel@suse.cz>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <20031001100929.GB398@elf.ucw.cz>
References: <1064569422.21735.11.camel@ulysse.olympe.o2t>
	 <20030926102403.GA8864@ucw.cz>  <20031001100929.GB398@elf.ucw.cz>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-3ozUfy63F3CWe7QzLh1B"
Organization: Adresse personelle
Message-Id: <1065013591.29212.1.camel@ulysse.olympe.o2t>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-7) 
Date: Wed, 01 Oct 2003 15:06:31 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3ozUfy63F3CWe7QzLh1B
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Le mer 01/10/2003 =E0 12:09, Pavel Machek a =E9crit :
> Hi!
>=20
> > Of course this won't fix any problems with USB, if there are still any.
> > My USB keyboard works just perfectly, no problems with the autorepeat.
>=20
> Can you try running your system with interrupts disabled for 100ms+
> sometimes? That should show any bugs/races in keyboard code. Perhaps
> you have good hardware that never ever disables interrupts for that
> long, but other people have more broken stuff.

Will try - as soon as I restore the raid that the last 2.6.0-test5-bk
snapshots ate:(

I had something setup last evening unfortunately the system's gone AWOL
since.

Cheers,

--=20
Nicolas Mailhot

--=-3ozUfy63F3CWe7QzLh1B
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/etFWI2bVKDsp8g0RAh8MAKDX6kOnoJVybCMmswRBQKdXCihKngCaA3N5
aagbgraH2fcVRdG/Ee7exhs=
=mqNI
-----END PGP SIGNATURE-----

--=-3ozUfy63F3CWe7QzLh1B--

