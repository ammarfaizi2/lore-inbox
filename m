Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262285AbTFOOtl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 10:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262288AbTFOOtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 10:49:40 -0400
Received: from diale015.ppp.lrz-muenchen.de ([129.187.28.15]:4230 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id S262285AbTFOOtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 10:49:39 -0400
Subject: Re: linux-2.4.21 released
From: Daniel Egger <degger@fhm.edu>
To: Damian =?iso-8859-2?Q?Ko=B3kowski?= <deimos@deimos.one.pl>
In-Reply-To: <Pine.LNX.4.44.0306132325110.26388-100000@wenus.deimos.one.pl>
References: <Pine.LNX.4.44.0306132325110.26388-100000@wenus.deimos.one.pl>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-nU9jHarNTRHNGElcNnWq"
Message-Id: <1055687340.22962.21.camel@sonja>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 15 Jun 2003 16:29:01 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-nU9jHarNTRHNGElcNnWq
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: quoted-printable

Am Fre, 2003-06-13 um 23.31 schrieb Damian Ko=B3kowski:

> > Surprise, but ACPI never was the problem with this board... :)
> ROTFL

I know at least three persons for which ACPI works (one of them is me).

> Now you surprise me, so 2.4.21-rc8-ac1 with ACPI:
>=20
> 	CONFIG_X86_UP_APIC
> 	CONFIG_X86_UP_IOAPIC
>=20
> with module via-rhine on ECS_L7VTA works for you or not..?

Nope, it doesn't work, but the problem is the IOAPIC not ACPI....
It works if I disable the IOAPIC in the BIOS.

--=20
Servus,
       Daniel

--=-nU9jHarNTRHNGElcNnWq
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+7IKrchlzsq9KoIYRAkp5AKCIcOMDor03YjDktXdWNxg6Yb+1hwCghK9x
BFHYqVW0M3/9sJii9bmjV/w=
=Na/x
-----END PGP SIGNATURE-----

--=-nU9jHarNTRHNGElcNnWq--

