Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261476AbSIVJsc>; Sun, 22 Sep 2002 05:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262012AbSIVJsc>; Sun, 22 Sep 2002 05:48:32 -0400
Received: from node-d-1ef6.a2000.nl ([62.195.30.246]:19182 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S261476AbSIVJsb>; Sun, 22 Sep 2002 05:48:31 -0400
Subject: Re: make bzImage fails on 2.5.38
From: Arjan van de Ven <arjanv@fenrus.demon.nl>
To: Alexander Viro <viro@math.psu.edu>
Cc: Aniruddha Shankar <ashankar@nls.ac.in>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0209220229480.22740-100000@weyl.math.psu.edu>
References: <Pine.GSO.4.21.0209220229480.22740-100000@weyl.math.psu.edu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-SU7AgSgmX6GKGnsbNZ1L"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 22 Sep 2002 11:54:44 +0200
Message-Id: <1032688484.2150.2.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-SU7AgSgmX6GKGnsbNZ1L
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2002-09-22 at 08:31, Alexander Viro wrote:
>=20
>=20
> On Sun, 22 Sep 2002, Aniruddha Shankar wrote:
>=20
> > First post to the list, I've followed the format given in REPORTING-BUG=
S
> >=20
> > 1. make bzImage fails on 2.5.38
>=20
> Arrgh.
>=20
> ed fs/partitions/check.c <<EOF
> 365s/devfs_handle/cdroms/
> w
> q
> EOF

using ed now that you can't post vi scripts ?

/me runs

--=-SU7AgSgmX6GKGnsbNZ1L
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9jZNkxULwo51rQBIRAtHOAKCZtcUOa95SkdEXuTdOnwHTjUyQNgCePbok
32DyuTXyD7Cs5AocJ+o+zrU=
=gvbi
-----END PGP SIGNATURE-----

--=-SU7AgSgmX6GKGnsbNZ1L--

