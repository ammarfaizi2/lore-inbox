Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265481AbSKFO34>; Wed, 6 Nov 2002 09:29:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265508AbSKFO3z>; Wed, 6 Nov 2002 09:29:55 -0500
Received: from B54ba.pppool.de ([213.7.84.186]:16065 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id <S265481AbSKFO3z>; Wed, 6 Nov 2002 09:29:55 -0500
Subject: Re: [BK][PATCH] Reiser4, will double Linux FS performance,
	pleaseapply
From: Daniel Egger <degger@fhm.edu>
To: reiser@namesys.com
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3DC87154.1030601@namesys.com>
References: <15816.20406.532821.177470@wombat.chubb.wattle.id.au> 
	<3DC87154.1030601@namesys.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-0XNnj1m484Xn41DUD0Sq"
X-Mailer: Ximian Evolution 1.0.8 
Date: 06 Nov 2002 15:25:16 +0100
Message-Id: <1036592716.2654.14.camel@sonja.de.interearth.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-0XNnj1m484Xn41DUD0Sq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Mit, 2002-11-06 um 02.33 schrieb reiser:

> There is also a longer PhD thesis by her.  10 minutes is about as much=20
> work as I personally am willing to lose and try to remember.  Avoiding=20
> 75% of writes instead of 20% is a substantial performance gain worth=20
> paying a cost for.  Unfortunately it is not easy to say if it is worth=20
> that much cost, but I suspect it is.  An approach we are exploring is=20
> for blocks to reach disk earlier than that if the device is not=20
> congested, on the grounds that if not much IO is occuring, then=20
> performance is not important.

Assuming your 10 minutes are just a default and tunable by sysctl I
hardly can see any problems at all. Paranoid people can set it to=20
make any tradeoff between performance and speed they'd like including
setting it to 0, no?
=20
--=20
Servus,
       Daniel

--=-0XNnj1m484Xn41DUD0Sq
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA9ySZMchlzsq9KoIYRAjmrAKC7GyxZZIdO/A4p0x9RdmUI6yDpAQCgp+WW
M6xOMrkj9QmIUo03cqfFKe0=
=F4BF
-----END PGP SIGNATURE-----

--=-0XNnj1m484Xn41DUD0Sq--

