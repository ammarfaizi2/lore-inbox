Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263135AbTCLKJP>; Wed, 12 Mar 2003 05:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263136AbTCLKJP>; Wed, 12 Mar 2003 05:09:15 -0500
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:16879 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP
	id <S263135AbTCLKJO>; Wed, 12 Mar 2003 05:09:14 -0500
Subject: Re: 2.5.63 accesses below %esp (was: Re: ntfs OOPS (2.5.63))
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Szakacsits Szabolcs <szaka@sienet.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0303120622290.15538-100000@divine.city.tvnet.hu>
References: <Pine.LNX.4.30.0303120622290.15538-100000@divine.city.tvnet.hu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-2/AbCyP9LqxkARfA8id6"
Organization: Red Hat, Inc.
Message-Id: <1047464392.1556.4.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 12 Mar 2003 11:19:52 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-2/AbCyP9LqxkARfA8id6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-03-12 at 07:07, Szakacsits Szabolcs wrote:
> On 11 Mar 2003, Linus Torvalds wrote:
> >
> > If there is a well-known list of compilers, we should put a BIG warning
> > in some core kernel file to guide people to upgrade (or maybe work
>=20
> Not enough, nobody would notice and today most end user doesn't
> compile the kernel himself, they are just shipped by a broken kernels.

and all vendors always ship -fno-frame-pointer kernels so far so those
users are ok! Until recently there was no way to build a non
-fno-frame-pointer kernel!

--=-2/AbCyP9LqxkARfA8id6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+bwnIxULwo51rQBIRAntYAJ9koKtRpiyBCWyAuFKmlKdNgJBiwgCfXpIZ
ipNXWU6Y8w8lv0LVURsQfc0=
=/PgZ
-----END PGP SIGNATURE-----

--=-2/AbCyP9LqxkARfA8id6--
