Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264286AbUGMOKb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264286AbUGMOKb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 10:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265151AbUGMOKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 10:10:31 -0400
Received: from sp36.amenworld.com ([62.193.200.26]:50596 "EHLO tuxedo-es.org")
	by vger.kernel.org with ESMTP id S264286AbUGMOK3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 10:10:29 -0400
Subject: Re: Kernel hacking option "Debug memory allocations" possible leak
	of PaX memory randomization
From: Lorenzo Hernandez Garcia-Hierro <lorenzo@gnu.org>
Reply-To: lorenzo@gnu.org
To: Marc-Christian Petersen <m.c.p@kernel.linux-systeme.com>
Cc: pageexec@freemail.hu, linux-kernel@vger.kernel.org
In-Reply-To: <200407131601.39909@WOLK>
References: <1089726693.3283.21.camel@localhost>  <200407131601.39909@WOLK>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Z+DCkmf4Zr3Vh0zLatkp"
Message-Id: <1089727818.3284.23.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 13 Jul 2004 16:10:18 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Z+DCkmf4Zr3Vh0zLatkp
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

Hi Marc,

El mar, 13-07-2004 a las 16:01, Marc-Christian Petersen escribi=F3:
> On Tuesday 13 July 2004 15:51, Lorenzo Hernandez Garcia-Hierro wrote:
>=20
> Hi Lorenzo,
>=20
> > Is anyone of you having the same situation, is it an unexpected behavio=
r or
> > it's a bug on the kernel source?
> > Is that option non-compatible with PaX RANDSTACK and the rest of PaX's
> > memory randomization features?
>=20
> CC pageexec at freemail dot hu - He's the PaX programmer.
>=20
> ciao, Marc
>=20

OK, thanks, i forget the K of RANDKSTACK, sorry.

Cheers,
--=20
Lorenzo Hernandez Garcia-Hierro <lorenzo@gnu.org>

--=-Z+DCkmf4Zr3Vh0zLatkp
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA8+1KDcEopW8rLewRAlSdAJ9BCp7VWJBEmPvwOsyyGIaeoLSFgwCgm4R7
6KTGHFUuzjEJqhChc4P4gQ0=
=IDBY
-----END PGP SIGNATURE-----

--=-Z+DCkmf4Zr3Vh0zLatkp--

