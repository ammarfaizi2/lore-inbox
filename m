Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267274AbUGVU7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267274AbUGVU7Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 16:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267272AbUGVU7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 16:59:24 -0400
Received: from wblv-254-37.telkomadsl.co.za ([165.165.254.37]:43194 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S267274AbUGVU6z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 16:58:55 -0400
Subject: Re: New dev model (was [PATCH] delete devfs)
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Adrian Bunk <bunk@fs.tum.de>, corbet@lwn.net,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <20040722160112.177fc07f.akpm@osdl.org>
References: <40FEEEBC.7080104@quark.didntduck.org>
	 <20040721231123.13423.qmail@lwn.net> <20040721235228.GZ14733@fs.tum.de>
	 <20040722025539.5d35c4cb.akpm@osdl.org> <20040722193337.GE19329@fs.tum.de>
	 <20040722160112.177fc07f.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-LiEIF6bmYbUSNwZxo/iI"
Message-Id: <1090530100.10205.40.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 22 Jul 2004 23:01:41 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-LiEIF6bmYbUSNwZxo/iI
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-07-23 at 01:01, Andrew Morton wrote:
> Adrian Bunk <bunk@fs.tum.de> wrote:
> >
> > my personal opinon is that this new development model isn't a good=20
> > idea from the point of view of users:
> >=20
> > There's much worth in having a very stable kernel. Many people use for=20
> > different reasons self-compiled ftp.kernel.org kernels.=20
>=20
> Well.  We'll see.  2.6 is becoming stabler, despite the fact that we're
> adding features.
>=20
> I wouldn't be averse to releasing a 2.6.20.1 which is purely stability
> fixes against 2.6.20 if there is demand for it.  Anyone who really cares
> about stability of kernel.org kernels won't be deploying 2.6.20 within a
> few weeks of its release anyway, so by the time they doodle over to
> kernel.org they'll find 2.6.20.2 or whatever.

I wont recommend this, as it screws with some (most?) things trying
to detect kernel version running from uname =3D)


--=20
Martin Schlemmer

--=-LiEIF6bmYbUSNwZxo/iI
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBACs0qburzKaJYLYRAotUAJsF+TXByQeXZg190V4TYyn+xoecMgCcC2EB
ZfqH7SnxwzQxzBA8UFdS1kY=
=Y1pC
-----END PGP SIGNATURE-----

--=-LiEIF6bmYbUSNwZxo/iI--

