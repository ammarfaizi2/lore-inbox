Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbTKOXyD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 18:54:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262186AbTKOXyD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 18:54:03 -0500
Received: from galileo.bork.org ([66.11.174.156]:3304 "HELO galileo.bork.org")
	by vger.kernel.org with SMTP id S262110AbTKOXyA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 18:54:00 -0500
Subject: Re: [2.6 patch] disallow modular BINFMT_ELF
From: Martin Hicks <mort@bork.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <3FB6BB35.8090001@pobox.com>
References: <20031115232600.GF7919@fs.tum.de>  <3FB6BB35.8090001@pobox.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-p3o7ekAVw9FHwF6jSx3c"
Message-Id: <1068940439.11462.230.camel@socrates>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 15 Nov 2003 18:53:59 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-p3o7ekAVw9FHwF6jSx3c
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2003-11-15 at 18:48, Jeff Garzik wrote:
> Adrian Bunk wrote:
> > modular BINFMT_ELF gives unresolved symbols in 2.4 .
> >=20
> > modular BINFMT_ELF gives the following unresolved symbols in 2.6:
>=20
>=20
> Interesting.   this causes me to wonder if we should bother making=20
> BINFMT_ELF an option at all...

I strikes me as something that everyone is going to say yes to.  If
someone really doesn't want ELF then they are probably smart enough to
change the Config script.

mh

--=20
Martin Hicks || mort@bork.org || PGP/GnuPG: 0x4C7F2BEE

--=-p3o7ekAVw9FHwF6jSx3c
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/tryX0ZUZrUx/K+4RArJjAJwLDSbge3yJ/SaLCzmEHQyvnoXXEQCgyodU
K0zrHMsD3Vi5wpUZR3SProU=
=hNM3
-----END PGP SIGNATURE-----

--=-p3o7ekAVw9FHwF6jSx3c--

