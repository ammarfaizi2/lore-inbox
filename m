Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261498AbSI1ODD>; Sat, 28 Sep 2002 10:03:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261502AbSI1ODC>; Sat, 28 Sep 2002 10:03:02 -0400
Received: from node-d-1ef6.a2000.nl ([62.195.30.246]:26094 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S261498AbSI1ODC>; Sat, 28 Sep 2002 10:03:02 -0400
Subject: Re: detect udma66 cable (vt82c686a)
From: Arjan van de Ven <arjanv@redhat.com>
To: Daniel Egger <degger@fhm.edu>
Cc: Dennis =?ISO-8859-1?Q?Bj=F6rklund?= <db@zigo.dhs.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1033221318.26190.20.camel@sonja.de.interearth.com>
References: <Pine.LNX.4.44.0209281253240.1342-100000@zigo.dhs.org> 
	<1033221318.26190.20.camel@sonja.de.interearth.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-lfgwTzIJsQa9WzRkqBwW"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 28 Sep 2002 16:10:42 +0200
Message-Id: <1033222243.2556.5.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-lfgwTzIJsQa9WzRkqBwW
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On Sat, 2002-09-28 at 15:55, Daniel Egger wrote:
> Am Sam, 2002-09-28 um 13.07 schrieb Dennis Bj=F6rklund:
>=20
> > I can't get my Gigabyte 7ZX-1 to detect my udma66 cable. It is a brand =
new=20
> > ata66/100 cable so I believe that the cable is not the problem.
> =20
> > As seen from /proc/ide/via below it thinks my cable is a 40w (on id0 I =
do=20
> > have a 40w so that is correct, but in ide1 there is a 80w).
> > The computer is a redhat 7.3 with kernel 2.4.18-4
>=20
> Same southbridgem, same kernel, same problem. I sent all sorts of
> messages for this one to Alan but so far there're no news on this
> matter.

ide1=3Data66 on the kernel commandline should fix it..



--=-lfgwTzIJsQa9WzRkqBwW
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9lbhixULwo51rQBIRAi+pAJ4rG1sMLiaeO+Km48epn4fcW0HAOQCfYQcj
hxKopMDFfBGATmmTpxoZm7g=
=mzIa
-----END PGP SIGNATURE-----

--=-lfgwTzIJsQa9WzRkqBwW--

