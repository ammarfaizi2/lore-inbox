Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263121AbUEGHNo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263121AbUEGHNo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 03:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263226AbUEGHNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 03:13:44 -0400
Received: from legolas.restena.lu ([158.64.1.34]:46531 "EHLO smtp.restena.lu")
	by vger.kernel.org with ESMTP id S263121AbUEGHNl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 03:13:41 -0400
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH]
	for idle=C1halt, 2.6.5
From: Craig Bradney <cbradney@zip.com.au>
To: Richard James <richard@techdrive.com.au>
Cc: Jesse Allen <the3dfxdude@hotmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <409B14F1.9090607@techdrive.com.au>
References: <20040423013039.GA4945@tesore.local>
	 <409B14F1.9090607@techdrive.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-gFumYaHy5kYKGa20rjkN"
Message-Id: <1083914015.8464.1.camel@amilo.bradney.info>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 07 May 2004 09:13:35 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gFumYaHy5kYKGa20rjkN
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-05-07 at 06:47, Richard James wrote:
> Jesse Allen wrote:
>=20
> >Len Brown wrote:
> > =20
> >
> >>Have you been able to hang the AN35N under any conditions?
> >>Old BIOS, non-vanilla kernel?
> >>   =20
> >>
> >
> >Yes, and I described that it will hang under the pre-Dec 5th BIOS in ano=
ther=20
> >mail.
> >
> >I still have images of the buggy BIOS, and the fixed one on my hard driv=
e.
> >They are also available at ftp://ftp.shuttle.com/BIOS/an35_n/ as
> >an35s00j.bin (Oct 2003)
> >an35s00l.bin (Dec 5th 2003)
> >
> > =20
> >
> ASUS have now supplied a BIOS update for the A7N8X-X which fixes the C1=20
> halt crash.
> dated the 2004/04/21.  So I assume that they will supply a patch for all=20
> nforce2 motherboards.

Only for the A7N8X-X though. I like their description of the fixes:
1. Improve some memory modules stability.

Did you apply it and then run lspci -xxx -vvv on it to find out?

Craig

--=-gFumYaHy5kYKGa20rjkN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAmzcei+pIEYrr7mQRAuz4AKCpJ+IdoJManIayJilibVzwS+OcWACffi+y
7uLqLHcgvC0r+hGFnoxwxXI=
=+IgE
-----END PGP SIGNATURE-----

--=-gFumYaHy5kYKGa20rjkN--

