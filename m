Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbTIZNI4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 09:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262177AbTIZNI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 09:08:56 -0400
Received: from smtp3.clb.oleane.net ([213.56.31.19]:61164 "EHLO
	smtp3.clb.oleane.net") by vger.kernel.org with ESMTP
	id S262176AbTIZNIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 09:08:54 -0400
Subject: Re: Keyboard oddness.
From: Nicolas Mailhot <Nicolas.Mailhot@laposte.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1064572898.21735.17.camel@ulysse.olympe.o2t>
References: <1064569422.21735.11.camel@ulysse.olympe.o2t>
	 <20030926102403.GA8864@ucw.cz>
	 <1064572898.21735.17.camel@ulysse.olympe.o2t>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-sGle9HhAa75vQj+tkY+I"
Organization: Adresse personelle
Message-Id: <1064581715.23200.9.camel@ulysse.olympe.o2t>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-7) 
Date: Fri, 26 Sep 2003 15:08:36 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-sGle9HhAa75vQj+tkY+I
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


| > > > Couldn't it at least detect there's a problem ? Most people I know =
do not press a key
| > > > 2000+ times in a row during normal activity.
| > >=20
| > > You do. Scrolling up/down in a document is one example. And there is =
no
| > > point to limit the repeat to say 80 or 200 characters. You would stil=
l
| > > hate having 80 repeated characters and then it stopping.
| >=20
| > Well then only allow monster autorepeats for arrows then.
| > (they are never stuck in my board anyway;)

| And j, k, w, b, ., all function keys, <bs>, <del>, <cr>,
| <sp>, <tab> and any other key used by any editor or game for
| navigation, level control or other function where the same
| key would be used scores of times in in rapid sequence.

score << 2k+

I wrote about monster autorepeats not every single duplicated keypress.
I fully agree it's stupid to expect detecting every single bogus repeat.

However saying the system has no way to guess monster
autorepeats=3Dproblem is just plain wrong. There *are* thresholds after
which one can be 99% sure there is a problem (autorepeat gone mad or cat
sitting on the keyboard). No one is going to complain he has to release
a key every hundred or so repeats to confirm there's a human on the
other side of the keyboard.

Cheers,

--=20
Nicolas Mailhot

--=-sGle9HhAa75vQj+tkY+I
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/dDpTI2bVKDsp8g0RAjpRAKCNQlyKcZlxawIRYe1RpWETyGXB7QCfbesU
HM7QmN/06yjhuI60Ryi3DNQ=
=YRRR
-----END PGP SIGNATURE-----

--=-sGle9HhAa75vQj+tkY+I--

