Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262731AbVA1TDo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262731AbVA1TDo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 14:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261524AbVA1TAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 14:00:25 -0500
Received: from vds-320151.amen-pro.com ([62.193.204.86]:20109 "EHLO
	vds-320151.amen-pro.com") by vger.kernel.org with ESMTP
	id S262463AbVA1S7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 13:59:11 -0500
Subject: Re: [PATCH] OpenBSD Networking-related randomization port
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: netdev@oss.sgi.com,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, netdev@oss.sgi.com
In-Reply-To: <20050128105217.1dc5ef42@dxpl.pdx.osdl.net>
References: <1106932637.3778.92.camel@localhost.localdomain>
	 <20050128100229.5c0e4ea1@dxpl.pdx.osdl.net>
	 <1106937110.3864.5.camel@localhost.localdomain>
	 <20050128105217.1dc5ef42@dxpl.pdx.osdl.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-BcuLv7mz/04R3Q0MGGaK"
Date: Fri, 28 Jan 2005 19:58:37 +0100
Message-Id: <1106938717.3864.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-BcuLv7mz/04R3Q0MGGaK
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

El vie, 28-01-2005 a las 10:52 -0800, Stephen Hemminger escribi=F3:
> On Fri, 28 Jan 2005 19:31:50 +0100
> When I did the port randomization patch the benchmark that was most impac=
ted
> was LMBENCH.  The biggest change was in the communications latency result=
s.
>=20
> If you want, you can sign up for a free access to OSDL test machines
> and use STP to run lmbench and easily get before/after results.
>=20
> 1. Go to osdl.org and get associate account http://osdl.org/join_form
>=20
> 2. Submit patch to Patch Lifecycle Manager http://osdl.org/plm-cgi/plm
>=20
> 3. Choose test to run Scalable Test Platform (STP)=20
> http://osdl.org/lab_activities/kernel_testing/stp/

OK, many thanks.
Haven't noticed that (maybe 'cos I'm new in kernel hacking ;) )

I will submit there the new patch ASAP.

Cheers,
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-BcuLv7mz/04R3Q0MGGaK
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBB+otdDcEopW8rLewRAjBzAJ0d1Y8YNgM6bdc9CMipUhB/XoZmugCeOLNW
Z/bRa/Fe6nIowhi53+4o2mQ=
=qoMI
-----END PGP SIGNATURE-----

--=-BcuLv7mz/04R3Q0MGGaK--

