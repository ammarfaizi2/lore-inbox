Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262253AbTIZOND (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 10:13:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262262AbTIZOND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 10:13:03 -0400
Received: from smtp4.clb.oleane.net ([213.56.31.20]:62135 "EHLO
	smtp4.clb.oleane.net") by vger.kernel.org with ESMTP
	id S262253AbTIZOM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 10:12:58 -0400
Subject: Re: Keyboard oddness.
From: Nicolas Mailhot <Nicolas.Mailhot@laposte.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030926134116.GA9721@ucw.cz>
References: <1064569422.21735.11.camel@ulysse.olympe.o2t>
	 <20030926102403.GA8864@ucw.cz>
	 <1064572898.21735.17.camel@ulysse.olympe.o2t>
	 <1064581715.23200.9.camel@ulysse.olympe.o2t> <20030926134116.GA9721@ucw.cz>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-TTOwIubbzz2YZ3UsuMW1"
Organization: Adresse personelle
Message-Id: <1064585567.23200.15.camel@ulysse.olympe.o2t>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-7) 
Date: Fri, 26 Sep 2003 16:12:47 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-TTOwIubbzz2YZ3UsuMW1
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

Le ven 26/09/2003 =E0 15:41, Vojtech Pavlik a =E9crit :
> On Fri, Sep 26, 2003 at 03:08:36PM +0200, Nicolas Mailhot wrote:
>=20
> > | > > > Couldn't it at least detect there's a problem ? Most people I k=
now do not press a key
> > | > > > 2000+ times in a row during normal activity.
> > | > >=20
> > | > > You do. Scrolling up/down in a document is one example. And there=
 is no
> > | > > point to limit the repeat to say 80 or 200 characters. You would =
still
> > | > > hate having 80 repeated characters and then it stopping.
> > | >=20
> > | > Well then only allow monster autorepeats for arrows then.
> > | > (they are never stuck in my board anyway;)
> >=20
> > | And j, k, w, b, ., all function keys, <bs>, <del>, <cr>,
> > | <sp>, <tab> and any other key used by any editor or game for
> > | navigation, level control or other function where the same
> > | key would be used scores of times in in rapid sequence.
> >=20
> > score << 2k+
> >=20
> > I wrote about monster autorepeats not every single duplicated keypress.
> > I fully agree it's stupid to expect detecting every single bogus repeat=
.
> >=20
> > However saying the system has no way to guess monster
> > autorepeats=3Dproblem is just plain wrong. There *are* thresholds after
> > which one can be 99% sure there is a problem (autorepeat gone mad or ca=
t
> > sitting on the keyboard). No one is going to complain he has to release
> > a key every hundred or so repeats to confirm there's a human on the
> > other side of the keyboard.
>=20
> But what use would be this? You'd still get a screenful of 'j's for
> example, maybe only 200 instead of 2000, but where is the difference?

The difference being the system can then try to rescue my keyboard;)
Right now the only fix I have is to reboot the system because there is
precious little I can do with a stuck keyboard. Thank god software
reboot is always possible be it with the mouse or the acpi button.

(and this also solves the case when something falls on a keyboard which
does happen now and then. I don't mind a screen of j's when the
alternative is 200 j's screenfulls)

--=20
Nicolas Mailhot

--=-TTOwIubbzz2YZ3UsuMW1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/dElcI2bVKDsp8g0RAoFNAKDpfAo8FJPQ6K/u8ZDCMaLJl+UYXACgnLA8
y+AzgJKPNsB6STcvIP6dfYs=
=iRPz
-----END PGP SIGNATURE-----

--=-TTOwIubbzz2YZ3UsuMW1--

