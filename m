Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266347AbTAOM5t>; Wed, 15 Jan 2003 07:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266353AbTAOM5t>; Wed, 15 Jan 2003 07:57:49 -0500
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:59118 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP
	id <S266347AbTAOM5s>; Wed, 15 Jan 2003 07:57:48 -0500
Subject: Re: silly kernel taint question
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: SA <bullet.train@ntlworld.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200301151304.20502.bullet.train@ntlworld.com>
References: <200301151304.20502.bullet.train@ntlworld.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-3mr97hREqx1ByGInH4Tc"
Organization: Red Hat, Inc.
Message-Id: <1042635994.1397.4.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 15 Jan 2003 14:06:34 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3mr97hREqx1ByGInH4Tc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-01-15 at 14:04, SA wrote:
> Dear Kernel list,
>=20
> sorry for the stupid question but:
>=20
> My kernel module contains the line,
>=20
> MODULE_LICENSE("GPL");
>=20
> and when I insmod it I get
> Installing device driver
> Warning: loading pi_stage.o will taint the kernel: forced load

you're using insmod -f


--=-3mr97hREqx1ByGInH4Tc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+JVzaxULwo51rQBIRAhhfAKCDYXmOuYVHxhVcIc8LNKUY6l18hQCdE+wj
zkFO/0RMuxvhx8b51xuNUFg=
=ob98
-----END PGP SIGNATURE-----

--=-3mr97hREqx1ByGInH4Tc--
