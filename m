Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264198AbUEHJWb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264198AbUEHJWb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 05:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264201AbUEHJWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 05:22:31 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:3062 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S264198AbUEHJW3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 05:22:29 -0400
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH]
From: Ian Kumlien <pomac@vapor.com>
To: Richard James <richard@techdrive.com.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <409C70CC.7040503@techdrive.com.au>
References: <1083914992.2797.82.camel@big>
	 <409C70CC.7040503@techdrive.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-LGfvPq9TOltQmOsxe7R6"
Message-Id: <1084008147.2797.93.camel@big>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 08 May 2004 11:22:27 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-LGfvPq9TOltQmOsxe7R6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-05-08 at 07:31, Richard James wrote:
> Ian Kumlien wrote:
>=20
> >>ASUS have now supplied a BIOS update for the A7N8X-X which fixes the=20
> >>C1 halt crash. dated the 2004/04/21.  So I assume that they will=20
> >>supply a patch for all nforce2 motherboards.
> >>   =20
> >>
> >
> >you mean the 1009 bios? It doesn't fix anything.
> >I'm using it and:
> >
> >dmesg output:
> >...
> >Asus A7N8X-X detected: BIOS IRQ0 pin2 override will be ignored
> >...
> >PCI: nForce2 C1 Halt Disconnect fixup
> >...
> >
> >(I'm the one that told Len about the new bios that doesn't fix the pin2
> >bug and afair, the C1 Halt Disconnect fix checked for flawed values, ie,
> >this bios dosn't fix anything...)
> > =20
> >
> Actually you are right I just retested it and my system still locks up.=20
> I must have done something wrong on the origional testing.
>=20
> My apologies

Np, the bug is somewhat annoying in that sometimes the machine has to be
running for several days. I updated that bios the same day it was
released.. (i missed the actual upload with some hours)

It only fixes what it says in the change log =3DP... And i had just been
in contact with them pointing them to information from Allen Martin
about the pin2 that should be pin0 bug and nothing has happened.

Now i have to find where it was that i sent that bugreport again, since
the common "international" support thingy dosn't work, and hasn't for
some time =3DP.

--=20
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net

--=-LGfvPq9TOltQmOsxe7R6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAnKbS7F3Euyc51N8RAhebAJ4rkZz2XMNar5UgaqyfhVSJDu2H7ACgpUUg
Ewx4icrFfjJ0gP6kE29/1MM=
=3tt1
-----END PGP SIGNATURE-----

--=-LGfvPq9TOltQmOsxe7R6--

