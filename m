Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262872AbSJaTp2>; Thu, 31 Oct 2002 14:45:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262906AbSJaTp2>; Thu, 31 Oct 2002 14:45:28 -0500
Received: from B590c.pppool.de ([213.7.89.12]:48314 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id <S262872AbSJaTp1>; Thu, 31 Oct 2002 14:45:27 -0500
Subject: Re: CONFIG_TINY
From: Daniel Egger <degger@fhm.edu>
To: Rasmus Andersen <rasmus@jaquet.dk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021031092440.B5815@jaquet.dk>
References: <20021030233605.A32411@jaquet.dk>
	<Pine.NEB.4.44.0210310145300.20835-100000@mimas.fachschaften.tu-muenchen.de>
	  <20021031092440.B5815@jaquet.dk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-nsbJloBC87f/jgtMA7re"
X-Mailer: Ximian Evolution 1.0.8 
Date: 31 Oct 2002 20:33:21 +0100
Message-Id: <1036092802.7799.2.camel@sonja.de.interearth.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-nsbJloBC87f/jgtMA7re
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Don, 2002-10-31 um 09.24 schrieb Rasmus Andersen:

> I tried -Os once, and it didn't boot for me. So I dumped it.
> However, reading a mail from Zwane <somethingorother> about
> booting 2.5.x on a 4MB system I got the impression that he
> used Os, so I might give it another shot. Dropping down to
> i386 support, perhaps.

If you meant removing special support for faster processors this might
be a gain, if it was something along the lines of "-mcpu=3Di386
-mtune=3Di386" this would be pretty sure a loss resulting in bigger code.

--=20
Servus,
       Daniel

--=-nsbJloBC87f/jgtMA7re
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA9wYWBchlzsq9KoIYRAgTPAJ9roHY7M9n+gSK7RKDkZCq2hK76sQCfce4D
2QQR2CITF/jMqwOFtSSuNU0=
=I575
-----END PGP SIGNATURE-----

--=-nsbJloBC87f/jgtMA7re--

