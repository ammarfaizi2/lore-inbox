Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932297AbWIJQWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbWIJQWy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 12:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbWIJQWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 12:22:54 -0400
Received: from hentges.net ([81.169.178.128]:18911 "EHLO
	h6563.serverkompetenz.net") by vger.kernel.org with ESMTP
	id S932292AbWIJQWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 12:22:52 -0400
Subject: Re: 2.6.18-rc5-mm1
From: Matthias Hentges <oe@hentges.net>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <45035286.8070209@goop.org>
References: <20060901015818.42767813.akpm@osdl.org>
	 <1157158847.20509.10.camel@mhcln03> <20060901183028.1c6da4df.akpm@osdl.org>
	 <44F93EB3.8050500@goop.org> <44F942B9.6050102@goop.org>
	 <20060902084440.GA13361@suse.de>  <45035286.8070209@goop.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-qe8EuXSeOYeH/DUvCXXG"
Date: Sun, 10 Sep 2006 18:24:15 +0200
Message-Id: <1157905455.8827.12.camel@mhcln03>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-qe8EuXSeOYeH/DUvCXXG
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Samstag, den 09.09.2006, 16:47 -0700 schrieb Jeremy Fitzhardinge:
> Greg KH wrote:
> > There are 9 MSI patches in my tree that you can just remove.  They were
> > just recently (a few hours ago) replaced with a total rewrite due to a
> > number of different problems that were found.  So I'd suggest just
> > waiting till the next -mm release to see if it works properly or not.
> >  =20
>=20
> I'm seeing exactly the same oops with CONFIG_MSI on 2.6.18-rc6-mm1.

Same here.
--=20
Matthias 'CoreDump' Hentges=20

My OS: Debian SID. Geek by Nature, Linux by Choice

--=-qe8EuXSeOYeH/DUvCXXG
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFBDwvAq2P5eLUP5IRAtyhAJ4uRRSidxA1o8kd/cvog+XpXV2gTgCcDOnv
WRYyy+4POYu8Ize8iQ4mMbc=
=iAnH
-----END PGP SIGNATURE-----

--=-qe8EuXSeOYeH/DUvCXXG--

