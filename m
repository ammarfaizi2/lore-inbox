Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261334AbVAaUFN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbVAaUFN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 15:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261344AbVAaUEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 15:04:36 -0500
Received: from vds-320151.amen-pro.com ([62.193.204.86]:34458 "EHLO
	vds-320151.amen-pro.com") by vger.kernel.org with ESMTP
	id S261334AbVAaUD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 15:03:56 -0500
Subject: Re: [PATCH] OpenBSD Networking-related randomization port
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: Valdis.Kletnieks@vt.edu
Cc: Adrian Bunk <bunk@stusta.de>, Arjan van de Ven <arjan@infradead.org>,
       Stephen Hemminger <shemminger@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, netdev@oss.sgi.com,
       Hank Leininger <hlein@progressive-comp.com>
In-Reply-To: <200501311942.j0VJgIYs016952@turing-police.cc.vt.edu>
References: <1106932637.3778.92.camel@localhost.localdomain>
	 <20050128100229.5c0e4ea1@dxpl.pdx.osdl.net>
	 <1106937110.3864.5.camel@localhost.localdomain>
	 <20050128105217.1dc5ef42@dxpl.pdx.osdl.net>
	 <1106944492.3864.30.camel@localhost.localdomain>
	 <1106945266.7776.41.camel@laptopd505.fenrus.org>
	 <200501290915.j0T9FkVY012948@turing-police.cc.vt.edu>
	 <20050131165025.GN18316@stusta.de>
	 <200501311942.j0VJgIYs016952@turing-police.cc.vt.edu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-AVmFsIIHHG+gKFoHrkir"
Date: Mon, 31 Jan 2005 21:03:19 +0100
Message-Id: <1107201800.3754.125.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-AVmFsIIHHG+gKFoHrkir
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

El lun, 31-01-2005 a las 14:42 -0500, Valdis.Kletnieks@vt.edu escribi=F3:
> On Mon, 31 Jan 2005 17:50:25 +0100, Adrian Bunk said:
> > On Sat, Jan 29, 2005 at 04:15:43AM -0500, Valdis.Kletnieks@vt.edu wrote=
:
>=20
> > > Note that obsd_rand.c started off life as a BSD-licensed file - I was=
 told
> > > that was a show-stopper when I submitted basically the same patch a w=
hile back.
> > >...
> >=20
> > At least the three clause BSD license is GPL compatible.
>=20
> The copy of obsd_rand.c I have hass the problematic 4-clause version.  It=
 looks
> to me like we'd need to get Michael Shalayeff, Theodore T'so, and Niels P=
rovos
> to all agree to re-license under the 3-clause variant.  Using Arjan's cod=
e is
> most likely the better approach...

Then we would in that way ;)

Arjan, I will give it a further look, is there anything you want to
comment about it before I start?

I will re-code it to put the helper functions in random.c.

Thanks in advance,
Cheers.
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-AVmFsIIHHG+gKFoHrkir
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBB/o8HDcEopW8rLewRAjDtAKCMssmkFWhRzK5v//8h1Fpe7VnpegCfc2In
SI487ff/iOYdkrjafiSATi0=
=mga2
-----END PGP SIGNATURE-----

--=-AVmFsIIHHG+gKFoHrkir--

