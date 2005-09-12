Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751203AbVILIBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbVILIBg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 04:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbVILIBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 04:01:36 -0400
Received: from ctb-mesg8.saix.net ([196.25.240.88]:6903 "EHLO
	ctb-mesg8.saix.net") by vger.kernel.org with ESMTP id S1751203AbVILIBf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 04:01:35 -0400
Subject: Re: [GIT PATCH] Remove devfs from 2.6.13
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: David Lang <david.lang@digitalinsight.com>, Valdis.Kletnieks@vt.edu,
       Greg KH <gregkh@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20050911110214.GA16408@thunk.org>
References: <20050909214542.GA29200@kroah.com>
	 <Pine.LNX.4.62.0509101742300.28852@qynat.qvtvafvgr.pbz>
	 <200509110713.j8B7DsNR021781@turing-police.cc.vt.edu>
	 <Pine.LNX.4.62.0509110016110.29141@qynat.qvtvafvgr.pbz>
	 <20050911110214.GA16408@thunk.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-5bpolknXJX2nZ38/j1CB"
Date: Mon, 12 Sep 2005 10:01:01 +0200
Message-Id: <1126512061.14207.36.camel@lycan.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5bpolknXJX2nZ38/j1CB
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2005-09-11 at 07:02 -0400, Theodore Ts'o wrote:
> On Sun, Sep 11, 2005 at 12:20:06AM -0700, David Lang wrote:
> > >I'll bite - what distros are shipping a kernel 2.6.10 or later and sti=
ll
> > >using devfs?
> > >
> > I'll admit I don't keep track of the distros and what kernels and featu=
res=20
> > they are useing. I think I've heard people mention gentoo, but I=20
> > haven't verified this.
>=20

Why do people always remember us as using devfs, instead of being one of
the first distro's supporting it (if not the first) ? :(  I already
added support for udev to the initscripts back in Sep 2003, and added
the udev-0.2 package to the tree in Oct 2003.

> Nope, not Gentoo --- Greg KH fixed gentoo a while ago.  :-)
>=20

Not entirely true, but he did start to maintain the udev package around
udev-022.


--=20
Martin Schlemmer


--=-5bpolknXJX2nZ38/j1CB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDJTW9qburzKaJYLYRAhGbAJ0Xmow/eDUD3E5wZBo/TBj1mJNhuACfarQl
OW0AjelLtoSDfpVq8T8/5CI=
=9vbU
-----END PGP SIGNATURE-----

--=-5bpolknXJX2nZ38/j1CB--

