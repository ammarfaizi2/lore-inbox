Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261529AbSL1Lsk>; Sat, 28 Dec 2002 06:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261600AbSL1Lsk>; Sat, 28 Dec 2002 06:48:40 -0500
Received: from zeus.kernel.org ([204.152.189.113]:63188 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261529AbSL1Lsj>;
	Sat, 28 Dec 2002 06:48:39 -0500
Subject: Re: [PATCH] amd756 and amd8111 sensors support
From: Arjan van de Ven <arjanv@redhat.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200212280303.gBS33o628113@hera.kernel.org>
References: <200212280303.gBS33o628113@hera.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-oIlZ3DsiNd7wafpp5Jmh"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 28 Dec 2002 12:46:42 +0100
Message-Id: <1041076002.1485.2.camel@laptop.fenrus.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-oIlZ3DsiNd7wafpp5Jmh
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2002-12-26 at 22:55, Linux Kernel Mailing List wrote:
> ChangeSet 1.958, 2002/12/26 13:55:05-08:00, pavel@ucw.cz
>=20
> 	[PATCH] amd756 and amd8111 sensors support
> =09
> 	Add support for amd756 and amd8111 sensors
>=20
>=20
> # This patch includes the following deltas:
> #	           ChangeSet	1.957   -> 1.958 =20
> #	include/linux/i2c-id.h	1.6     -> 1.7   =20
> #	drivers/i2c/i2c-core.c	1.11    -> 1.12  =20
> #	 drivers/i2c/Kconfig	1.1     -> 1.2   =20
> #	  drivers/char/mem.c	1.32    -> 1.33  =20
> #	drivers/i2c/i2c-proc.c	1.7     -> 1.8   =20
> #	include/linux/i2c-proc.h	1.2     -> 1.3   =20
> #	         MAINTAINERS	1.112   -> 1.113 =20
> #	drivers/i2c/i2c-dev.c	1.17    -> 1.18  =20
> #	    drivers/Makefile	1.27    -> 1.28  =20
> #	               (new)	        -> 1.1     drivers/i2c/chips/Makefile
> #	               (new)	        -> 1.1     drivers/i2c/chips/lm75.c
> #	               (new)	        -> 1.1     drivers/i2c/chips/sensors.c
> #	               (new)	        -> 1.1     drivers/i2c/chips/adm1021.c
> #	               (new)	        -> 1.1     drivers/i2c/busses/Makefile
> #	               (new)	        -> 1.1     drivers/i2c/busses/i2c-mainboar=
d.c
> #	               (new)	        -> 1.1     drivers/i2c/chips/Kconfig
> #	               (new)	        -> 1.1     drivers/i2c/busses/i2c-amd8111.=
c
> #	               (new)	        -> 1.1     drivers/i2c/busses/i2c-amd756.c
> #	               (new)	        -> 1.1     drivers/i2c/busses/Kconfig
> #	               (new)	        -> 1.1     include/linux/sensors.h
> #

cool! lm_sensors finally in 2.5!

--=-oIlZ3DsiNd7wafpp5Jmh
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA+DY8ixULwo51rQBIRAuLGAJ9TBb/bwjm1N3RBYv26nfDB2il3ggCdG14e
T1FZcFtZHibXegaqM1GEATU=
=AEAC
-----END PGP SIGNATURE-----

--=-oIlZ3DsiNd7wafpp5Jmh--
