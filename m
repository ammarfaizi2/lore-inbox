Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262276AbTIZOum (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 10:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262278AbTIZOum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 10:50:42 -0400
Received: from smtp2.clb.oleane.net ([213.56.31.18]:24516 "EHLO
	smtp2.clb.oleane.net") by vger.kernel.org with ESMTP
	id S262276AbTIZOuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 10:50:35 -0400
Subject: Re: Keyboard oddness.
From: Nicolas Mailhot <Nicolas.Mailhot@laposte.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030926142607.GA10344@ucw.cz>
References: <1064569422.21735.11.camel@ulysse.olympe.o2t>
	 <20030926102403.GA8864@ucw.cz>
	 <1064572898.21735.17.camel@ulysse.olympe.o2t>
	 <1064581715.23200.9.camel@ulysse.olympe.o2t> <20030926134116.GA9721@ucw.cz>
	 <1064585567.23200.15.camel@ulysse.olympe.o2t>
	 <20030926141750.GA10183@ucw.cz>
	 <1064586116.23200.17.camel@ulysse.olympe.o2t>
	 <20030926142607.GA10344@ucw.cz>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-BLXWEBYvurJDwAEDCkFM"
Organization: Adresse personelle
Message-Id: <1064587824.23200.19.camel@ulysse.olympe.o2t>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-7) 
Date: Fri, 26 Sep 2003 16:50:25 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-BLXWEBYvurJDwAEDCkFM
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

Le ven 26/09/2003 =E0 16:26, Vojtech Pavlik a =E9crit :
> On Fri, Sep 26, 2003 at 04:21:57PM +0200, Nicolas Mailhot wrote:
> > Le ven 26/09/2003 ? 16:17, Vojtech Pavlik a =E9crit :
> > > On Fri, Sep 26, 2003 at 04:12:47PM +0200, Nicolas Mailhot wrote:
> > > =20
> > > > The difference being the system can then try to rescue my keyboard;=
)
> > > > Right now the only fix I have is to reboot the system because there=
 is
> > > > precious little I can do with a stuck keyboard. Thank god software
> > > > reboot is always possible be it with the mouse or the acpi button.
> > > >=20
> > > > (and this also solves the case when something falls on a keyboard w=
hich
> > > > does happen now and then. I don't mind a screen of j's when the
> > > > alternative is 200 j's screenfulls)
> > >=20
> > > You can simply press any key and it'll stop repeating.=20
> > >=20
> > > If that doesn't work, you have a more severe problem than a stuck key=
,
> > > that wouldn't be solved by stopping the repeat.
> >=20
> > It stops the repeat all right.
> > The problem is the keyboard is dead afterwards:(
>=20
> That's very interesting. Can you enable DEBUG in i8042.c and post a log?

Will it be of any use for an USB keyboard ? (just asking)

Cheers,

--=20
Nicolas Mailhot

--=-BLXWEBYvurJDwAEDCkFM
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/dFItI2bVKDsp8g0RArEYAJ43hdjv3zfJFwlw3ilgtjXpE98/jQCg44jF
Xxwo3yYvrMSopcxR4/OSkh0=
=ZJ8A
-----END PGP SIGNATURE-----

--=-BLXWEBYvurJDwAEDCkFM--

