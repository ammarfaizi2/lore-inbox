Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758385AbWLBThT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758385AbWLBThT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 14:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758422AbWLBThT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 14:37:19 -0500
Received: from bart.ott.istop.com ([66.11.172.99]:13981 "EHLO jukie.net")
	by vger.kernel.org with ESMTP id S1758385AbWLBThR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 14:37:17 -0500
Date: Sat, 2 Dec 2006 14:37:16 -0500
From: Bart Trojanowski <bart@jukie.net>
To: Prakash Punnoor <prakash@punnoor.de>, linux-kernel@vger.kernel.org
Subject: Re: nforce chipset + dualcore x86-64: Oops, NMI, Null pointer deref, etc
Message-ID: <20061202193716.GE20337@jukie.net>
References: <20061202172208.GC20337@jukie.net> <200612021840.48073.prakash@punnoor.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="twz1s1Hj1O0rHoT0"
Content-Disposition: inline
In-Reply-To: <200612021840.48073.prakash@punnoor.de>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--twz1s1Hj1O0rHoT0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Prakash Punnoor <prakash@punnoor.de> [061202 13:32]:
> Am Samstag 02 Dezember 2006 18:22 schrieb Bart Trojanowski:
> > In summary, I have an Opteron 170 in a Shuttle SN25P (nforce4 chipset).
> > I've tested the ram overnight and swapped out every component in the
> > system except for the HDDs.  I see these problems only with the
> > dual-core, and even on an older Asus nforce4 based motherboard.
> > noticed the following events (the complete dmesg is included below).
>=20
> > [    0.000000] Nvidia board detected. Ignoring ACPI timer override.
> > [    0.000000] If you got timer trouble try acpi_use_timer_override
>=20
> Have you tried this?

I saw the suggestions, but I didn't understand what that was asking.  I
will checkout that code.

Cheers,

-Bart

--=20
				WebSig: http://www.jukie.net/~bart/sig/

--twz1s1Hj1O0rHoT0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFcdXs/zRZ1SKJaI8RAmcgAJ96fLMfR8YUdAuwer+BWI6Gb4u3PQCg5kAg
hHfc3I+PIs6EZA/X6HKeu+8=
=27VA
-----END PGP SIGNATURE-----

--twz1s1Hj1O0rHoT0--
