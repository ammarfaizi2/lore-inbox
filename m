Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263131AbTCLKCj>; Wed, 12 Mar 2003 05:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263132AbTCLKCj>; Wed, 12 Mar 2003 05:02:39 -0500
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:16879 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP
	id <S263131AbTCLKCd>; Wed, 12 Mar 2003 05:02:33 -0500
Subject: Re: [2.4.19] How to get the path name of a struct dentry
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Torsten Foertsch <torsten.foertsch@gmx.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200303121033.08560.torsten.foertsch@gmx.net>
References: <200303121033.08560.torsten.foertsch@gmx.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-AQZWJaH76RI/zcx525mM"
Organization: Red Hat, Inc.
Message-Id: <1047463991.1556.1.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 12 Mar 2003 11:13:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-AQZWJaH76RI/zcx525mM
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-03-12 at 10:33, Torsten Foertsch wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> Hi,
>=20
> Assuming I have got a particular (struct dentry*)dp, how can I get it's f=
ull=20
> path name.

the question also is "in which namespace do you want the full path name"
and which chroot and ... There is no such thing as *the* full path name.

--=-AQZWJaH76RI/zcx525mM
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+bwg3xULwo51rQBIRAqjfAJ4znCsnQ8e352XA5YIIEQUlBAKI/QCdHIjJ
D0NAJyN7mkC0OAiOg/jNL48=
=EIwg
-----END PGP SIGNATURE-----

--=-AQZWJaH76RI/zcx525mM--
