Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265369AbUBFKHd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 05:07:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265379AbUBFKHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 05:07:33 -0500
Received: from legolas.restena.lu ([158.64.1.34]:40639 "EHLO smtp.restena.lu")
	by vger.kernel.org with ESMTP id S265369AbUBFKHb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 05:07:31 -0500
Subject: Re: [ACPI] acpi problem with nforce motherboards and ethernet
From: Craig Bradney <cbradney@zip.com.au>
To: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
Cc: Luis Miguel =?ISO-8859-1?Q?Garc=EDa?= <ktech@wanadoo.es>,
       david+challenge-response@blue-labs.org, linux-kernel@vger.kernel.org,
       a.verweij@student.tudelft.nl
In-Reply-To: <40235DBA.4030408@gmx.de>
References: <402298C7.5050405@wanadoo.es> <40229D2C.20701@blue-labs.org>
	 <4022B55B.1090309@wanadoo.es>  <20040205154059.6649dd74.akpm@osdl.org>
	 <1076026496.16107.23.camel@athlonxp.bradney.info>
	 <4022DE3C.1080905@wanadoo.es> <4022E209.3040909@gmx.de>
	 <4022E3C8.4020704@wanadoo.es>  <4022E69B.5070606@gmx.de>
	 <1076029281.23586.36.camel@athlonxp.bradney.info> <40235DBA.4030408@gmx.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ccN1p3xFOOw0X1DrLI08"
Message-Id: <1076062051.16107.49.camel@athlonxp.bradney.info>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 06 Feb 2004 11:07:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ccN1p3xFOOw0X1DrLI08
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-02-06 at 10:26, Prakash K. Cheemplavam wrote:
> Craig Bradney wrote:
> > On Fri, 2004-02-06 at 01:58, Prakash K. Cheemplavam wrote:
> >=20
> >>>There is a way to "activate" cpu Disconnect? or it gets enabled by=20
> >>>simply applying it?
> >>
> >>In newer Abit BIOSes there is an option, or you use athcool.
> >>
> >>
> >>
> >>>Yes, I have a Abit motherboards, perhaps it's the problem with the bio=
s.
> >>
> >>I have an Abit NF7-S Rev2 with latest Bios.
> >=20
> >=20
> > As noted in my last post.. you dont NEED athcool OR Disconnect to get
> > stability..=20
> >=20
> > I've only ever run athcool to check the status.. and my BIOS doesnt hav=
e
> > disconnect.
> >=20
> > A7N8X Deluxe V2 BIOS 1007.. 11 days uptime here.. haven had a crash
> > since Ross released those patches ages ago.
>=20
> WITHOUT Disconnect my System is stable, but hotter when idle, so that is=20
> not the point. Ross wanted the patched to work with APIC and Disconnect.
>=20
> DO you guys use APIC (not ACPI)? I use both APIC (and local APIC) and=20
> ACPI. ACPI is not the problem (unless they break something...) but APIC=20
> and CPU Disconnect makes trouble on nforce2.

athcool reports:
nVIDIA nForce2 (10de 01e0) found
'Halt Disconnect and Stop Grant Disconnect' bit is enabled.

I have never used athcool to turn it off, and I don't have a BIOS
option. APIC, local APIC and ACPI are all on.

Craig

--=-ccN1p3xFOOw0X1DrLI08
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAI2dji+pIEYrr7mQRAlnCAJ46EH7i9npfG0mFmrLlLmvfWceO3QCgjgGJ
n8LLl4qmJJYXJcd2oXUz1tA=
=GC5B
-----END PGP SIGNATURE-----

--=-ccN1p3xFOOw0X1DrLI08--

