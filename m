Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263204AbTCSVbX>; Wed, 19 Mar 2003 16:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263205AbTCSVbX>; Wed, 19 Mar 2003 16:31:23 -0500
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:18162 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP
	id <S263204AbTCSVbU>; Wed, 19 Mar 2003 16:31:20 -0500
Subject: Re: Deprecating .gz format on kernel.org
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Tigran Aivazian <tigran@veritas.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, mirrors <mirrors@kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0303192107270.3901-100000@einstein31.homenet>
References: <Pine.LNX.4.44.0303192107270.3901-100000@einstein31.homenet>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-13sto8sb5HCJzTnNbAAS"
Organization: Red Hat, Inc.
Message-Id: <1048110127.1534.8.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 19 Mar 2003 22:42:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-13sto8sb5HCJzTnNbAAS
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-03-19 at 22:12, Tigran Aivazian wrote:
> On Wed, 19 Mar 2003, H. Peter Anvin wrote:
> > i) Does this sound reasonable to everyone?  In particular, is there any
> > loss in losing the "original" compressed files?
>=20
> No, there is at least one reason for the "original" .gz files. Here are=20
> the logical steps:
>=20
> a) any Linux distribution contains their own "linux" package with the=20
> source base being "vanilla" Linux .tar.gz file

I can't speak for the others, but Red Hat Linux uses the .bz2 files in
kernel rpms

--=-13sto8sb5HCJzTnNbAAS
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+eOQvxULwo51rQBIRApw+AJ9gJun1+0svIH1LKha0mnDIWgKQkwCcD/LR
zd+cBnf1ZY7gvR2VFcczaUw=
=L30I
-----END PGP SIGNATURE-----

--=-13sto8sb5HCJzTnNbAAS--
