Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266136AbUHOIXB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266136AbUHOIXB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 04:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266546AbUHOIXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 04:23:00 -0400
Received: from zero.voxel.net ([209.123.232.253]:5315 "EHLO zero.voxel.net")
	by vger.kernel.org with ESMTP id S266136AbUHOIW6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 04:22:58 -0400
Subject: Re: [PATCH] don't delete debian directory in official debian builds
From: Andres Salomon <dilinger@voxel.net>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <20040815081556.GA20555@mars.ravnborg.org>
References: <1092512343.3971.23.camel@spiral.internal>
	 <20040815071559.GB7182@mars.ravnborg.org>
	 <1092556593.20551.14.camel@toaster.hq.voxel.net>
	 <20040815081556.GA20555@mars.ravnborg.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-r8gkWZ1veaTvxYfiDhmR"
Date: Sun, 15 Aug 2004 04:23:11 -0400
Message-Id: <1092558191.20551.17.camel@toaster.hq.voxel.net>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.90 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-r8gkWZ1veaTvxYfiDhmR
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-08-15 at 10:15 +0200, Sam Ravnborg wrote:
> On Sun, Aug 15, 2004 at 03:56:32AM -0400, Andres Salomon wrote:
> > >=20
> > > Preference to 1).
> >=20
> > I'm not quite sure what you mean w/ #1.  You want Debian, which has use=
d
> > the debian/ subdirectory for years, to use something else for its kerne=
l
> > packages?
>=20
> Let the kernel use a directory named 'deb' to match the deb-pkg target.

That works for me.  I assume the idea is to use $(SRCDIR)/deb/debian
instead of $(SRCDIR)/debian.


--=20
Andres Salomon <dilinger@voxel.net>

--=-r8gkWZ1veaTvxYfiDhmR
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBHx1v78o9R9NraMQRAl9aAKCUJRnMUdWVTQ/L4klgUBMZyGCJZQCgmVKI
BiqCJRqvkcy20mzcDUSvvJI=
=PFO2
-----END PGP SIGNATURE-----

--=-r8gkWZ1veaTvxYfiDhmR--

