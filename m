Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbVARXRw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbVARXRw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 18:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbVARXRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 18:17:37 -0500
Received: from vds-320151.amen-pro.com ([62.193.204.86]:48870 "EHLO
	vds-320151.amen-pro.com") by vger.kernel.org with ESMTP
	id S261471AbVARXRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 18:17:18 -0500
Subject: Re: [ANNOUNCEMENT] Collision regression test suite released
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: Chris Wright <chrisw@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "linux-security-module@wirex.com" <linux-security-module@wirex.com>
In-Reply-To: <20050118150445.D24171@build.pdx.osdl.net>
References: <1106088908.3832.56.camel@localhost.localdomain>
	 <20050118150445.D24171@build.pdx.osdl.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-IQqfqRIql5EH0FjdVqNk"
Date: Wed, 19 Jan 2005 00:16:44 +0100
Message-Id: <1106090204.3832.62.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-IQqfqRIql5EH0FjdVqNk
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

El mar, 18-01-2005 a las 15:04 -0800, Chris Wright escribi=F3:
> * Lorenzo Hern=E1ndez Garc=EDa-Hierro (lorenzo@gnu.org) wrote:
> > Past days I wrote about a regression test suite which i used to explain
> > why a grsecurity-like security improvement could be good for mainline
> > inclusion, and also, that at least the 50% of the faults it shows on
> > Vanilla sources could be solved without major blocking issues (aka big
> > deals, whatever else).
>=20
> Thanks, I'll take a look.  Do you categorize the faults in any way?

There are separators to make sections of similar tests, but still not a
nifty "per-type" sections organization.
I would like to improve it and use percents and such instead of simple
"Vulnerable" and "Not vulnerable" results, so, you can have a global
idea of the current security status.
Patches are welcome, as I don't have a lot of time now (school "normal"
rhythm started this week).

Cheers,
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org> [1024D/6F2B2DEC]
[2048g/9AE91A22] Hardened Debian head developer & project manager

--=-IQqfqRIql5EH0FjdVqNk
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBB7ZjcDcEopW8rLewRAtZIAKDFJc7mpTIQP//BVtB734+gE2W6SwCeIWZ0
dnQnJ83mWDPLsd9WJEYzMlA=
=roUx
-----END PGP SIGNATURE-----

--=-IQqfqRIql5EH0FjdVqNk--

