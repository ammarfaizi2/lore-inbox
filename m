Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262731AbTDEXOu (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 18:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262734AbTDEXOu (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 18:14:50 -0500
Received: from cpt-dial-196-30-178-31.mweb.co.za ([196.30.178.31]:21889 "EHLO
	nosferatu.lan") by vger.kernel.org with ESMTP id S262731AbTDEXOq (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Apr 2003 18:14:46 -0500
Subject: Re: Slab corruption with ext3-handle-cache.patch
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: Andrew Morton <akpm@digeo.com>
Cc: KML <linux-kernel@vger.kernel.org>
In-Reply-To: <1049584712.29758.21.camel@nosferatu.lan>
References: <1049580790.29758.8.camel@nosferatu.lan>
	 <20030405143852.67833364.akpm@digeo.com>
	 <1049582687.29758.11.camel@nosferatu.lan>
	 <20030405151025.249b261e.akpm@digeo.com>
	 <1049584712.29758.21.camel@nosferatu.lan>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-K2uX9NiaJx714fNfDyc2"
Organization: 
Message-Id: <1049584927.29758.23.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 06 Apr 2003 01:22:07 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-K2uX9NiaJx714fNfDyc2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-04-06 at 01:18, Martin Schlemmer wrote:
> On Sun, 2003-04-06 at 01:10, Andrew Morton wrote:
>=20
> >=20
> > So we're leaving an inode on the orphan list.  I wonder why that starte=
d
> > happening.  Thanks.
>=20
> Well, HTREE/dir_index is used on that partition.  I did mail about a
> weird problem some time ago where some files are deleted, but don't
> get removed (or something to that regards).  The thread was:
>=20
>   Corruption problem with ext3 and htree
>=20
> Sorry, cannot get onto http://www.lkml.org/ right now.
>=20

Err, what I tried to say here, was that I do not know if it could
be related ...


Regards,

--=20

Martin Schlemmer




--=-K2uX9NiaJx714fNfDyc2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+j2UcqburzKaJYLYRAsCuAJwMFCqSP3piIH9kj21rxwM+gnkwBQCeOuOE
YhoZ0ENE+95CUd+/jLaPT2w=
=3HY/
-----END PGP SIGNATURE-----

--=-K2uX9NiaJx714fNfDyc2--

