Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267076AbUBFBB2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 20:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267101AbUBFBB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 20:01:27 -0500
Received: from legolas.restena.lu ([158.64.1.34]:13289 "EHLO smtp.restena.lu")
	by vger.kernel.org with ESMTP id S267076AbUBFBBV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 20:01:21 -0500
Subject: Re: [ACPI] acpi problem with nforce motherboards and ethernet
From: Craig Bradney <cbradney@zip.com.au>
To: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
Cc: Luis Miguel =?ISO-8859-1?Q?Garc=EDa?= <ktech@wanadoo.es>,
       david+challenge-response@blue-labs.org, linux-kernel@vger.kernel.org,
       a.verweij@student.tudelft.nl
In-Reply-To: <4022E69B.5070606@gmx.de>
References: <402298C7.5050405@wanadoo.es> <40229D2C.20701@blue-labs.org>
	 <4022B55B.1090309@wanadoo.es>  <20040205154059.6649dd74.akpm@osdl.org>
	 <1076026496.16107.23.camel@athlonxp.bradney.info>
	 <4022DE3C.1080905@wanadoo.es> <4022E209.3040909@gmx.de>
	 <4022E3C8.4020704@wanadoo.es>  <4022E69B.5070606@gmx.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ypAt7RHmyP0Lp8MtqPEa"
Message-Id: <1076029281.23586.36.camel@athlonxp.bradney.info>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 06 Feb 2004 02:01:21 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ypAt7RHmyP0Lp8MtqPEa
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-02-06 at 01:58, Prakash K. Cheemplavam wrote:
> > There is a way to "activate" cpu Disconnect? or it gets enabled by=20
> > simply applying it?
>=20
> In newer Abit BIOSes there is an option, or you use athcool.
>=20
>=20
> > Yes, I have a Abit motherboards, perhaps it's the problem with the bios=
.
>=20
> I have an Abit NF7-S Rev2 with latest Bios.

As noted in my last post.. you dont NEED athcool OR Disconnect to get
stability..=20

I've only ever run athcool to check the status.. and my BIOS doesnt have
disconnect.

A7N8X Deluxe V2 BIOS 1007.. 11 days uptime here.. haven had a crash
since Ross released those patches ages ago.

Craig

--=-ypAt7RHmyP0Lp8MtqPEa
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAIudhi+pIEYrr7mQRAljlAJ4kORd1lZNhHwb9my/icqzLatreZgCfWahL
S4WyHRAuoe25HHy/WDmZERE=
=KEDp
-----END PGP SIGNATURE-----

--=-ypAt7RHmyP0Lp8MtqPEa--

