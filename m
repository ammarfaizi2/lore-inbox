Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263359AbTDMHaL (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 03:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263363AbTDMHaL (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 03:30:11 -0400
Received: from adsl-67-121-155-183.dsl.pltn13.pacbell.net ([67.121.155.183]:4832
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id S263359AbTDMHaK (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 13 Apr 2003 03:30:10 -0400
Date: Sun, 13 Apr 2003 00:41:56 -0700
To: James Simmons <jsimmons@infradead.org>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [FBDEV updates] Newest framebuffer fixes.
Message-ID: <20030413074156.GA2536@triplehelix.org>
References: <3E964EFA.60806@sixbit.org> <Pine.LNX.4.44.0304111921040.26995-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304111921040.26995-100000@phoenix.infradead.org>
User-Agent: Mutt/1.5.4i
From: Joshua Kwan <joshk@triplehelix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2003 at 07:21:16PM +0100, James Simmons wrote:
>=20
> > Thanks to James, I finally got radeonfb working, but I had to use the=
=20
> > attached driver instead.  Any word on whether this driver will be=20
> > included in the kernel seeing as the current one is so broken?
>=20
> Yes :-)=20

But this looks like the driver from when it was broken... it has all the
on-screen garbage when I boot. however, that cursor erraticness is gone
thanks to the old driver :)

I don't think going back to old stuff is the right way to think about
stuff like this :/

Kernel 2.5.66-mm3 contained a radeonfb.c which had the cursor issues but
fixed the problem with the bootup junk on the screen.

Regards,
Josh

--=20
New PGP public key: 0x27AFC3EE

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+mRTET2bz5yevw+4RAhDmAKDClWm3e5AO6GNcYjnIV/idXLJt1wCeK/Er
UQQQjGNOadT3FGZi6rokUOo=
=jKks
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
