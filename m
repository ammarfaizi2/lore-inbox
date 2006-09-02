Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750737AbWIBRYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbWIBRYz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 13:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbWIBRYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 13:24:55 -0400
Received: from hentges.net ([81.169.178.128]:25577 "EHLO
	h6563.serverkompetenz.net") by vger.kernel.org with ESMTP
	id S1750737AbWIBRYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 13:24:54 -0400
Subject: Re: sky2 hangs on me again: This time 200 kb/s IPv4 traffic, not
	easily reproducable
From: Matthias Hentges <oe@hentges.net>
To: shogunx <shogunx@sleekfreak.ath.cx>
Cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       Stephen Hemminger <shemminger@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0609012241230.9870-100000@sleekfreak.ath.cx>
References: <Pine.LNX.4.44.0609012241230.9870-100000@sleekfreak.ath.cx>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ivEMZIkLyqqZEjjrmFL8"
Date: Sat, 02 Sep 2006 19:25:49 +0200
Message-Id: <1157217949.18988.1.camel@mhcln03>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ivEMZIkLyqqZEjjrmFL8
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Freitag, den 01.09.2006, 22:41 -0400 schrieb shogunx:
> > >
> > > Has this not been fixed in the 2.6.18 git?
> >
> > Good question. I'll try 2.6.18-rc4-mm3 and report back.
>=20
> I am having no problems with 2.6.18-rc5, which I just built and tested.

The NIC is up and running for about 9hrs now w/ -rc4-mm3, thanks for the
heads up!
--=20
Matthias 'CoreDump' Hentges=20

Webmaster of hentges.net and OpenZaurus developer.
You can reach me in #openzaurus on Freenode.

My OS: Debian SID. Geek by Nature, Linux by Choice

--=-ivEMZIkLyqqZEjjrmFL8
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBE+b6cAq2P5eLUP5IRAt+SAJoD4LRoW0XjD/fnwJ/PD9rT0MRLCwCeMXgj
CRbb9+m+4ZV64uZWlyWMox0=
=A12e
-----END PGP SIGNATURE-----

--=-ivEMZIkLyqqZEjjrmFL8--


-- 
VGER BF report: H 0
