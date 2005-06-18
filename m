Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262155AbVFRWMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262155AbVFRWMX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 18:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262173AbVFRWMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 18:12:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:34495 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262155AbVFRWMP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 18:12:15 -0400
Subject: Re: bad: scheduling while atomic!: how bad?
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: David L <idht4n@hotmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <BAY104-F697F218C7E4E45B78BCDA84F70@phx.gbl>
References: <BAY104-F697F218C7E4E45B78BCDA84F70@phx.gbl>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-0ry73zqHI9LIe75aUgYx"
Organization: Red Hat, Inc.
Date: Sat, 18 Jun 2005 18:10:01 -0400
Message-Id: <1119132601.5871.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-0ry73zqHI9LIe75aUgYx
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2005-06-18 at 14:59 -0700, David L wrote:
> I'm seeing the message:
>=20
> bad: scheduling while atomic!
>=20
> I see this dozens of times when I'm writing to a nand flash device using =
a=20
> vendor-provided driver from Compulab in 2.6.8.1.  Does this mean the driv=
er=20
> has a bug or is incompatible with the preemptive configuration option?  H=
ow=20
> bad is "bad"?  Should I turn of the preemption option, ignore the message=
,=20
> or what?

can you post the sourcecode of the driver? it needs fixing...


--=-0ry73zqHI9LIe75aUgYx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCtJu4pv2rCoFn+CIRAqViAKCTue9M84lqDu4yp3wv2GCODRBeKgCggHAU
v7e7HsYNN3ElE3vwkFWz2xI=
=ZUT2
-----END PGP SIGNATURE-----

--=-0ry73zqHI9LIe75aUgYx--

