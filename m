Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263082AbUBNT6N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 14:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263101AbUBNT6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 14:58:13 -0500
Received: from smtp.golden.net ([199.166.210.31]:3857 "EHLO newsmtp.golden.net")
	by vger.kernel.org with ESMTP id S263082AbUBNT6K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 14:58:10 -0500
Date: Sat, 14 Feb 2004 14:57:43 -0500
From: Paul Mundt <lethal@linux-sh.org>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       jsimmons@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] back out fbdev sysfs support
Message-ID: <20040214195743.GA4844@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	viro@parcelfarce.linux.theplanet.co.uk,
	Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
	jsimmons@infradead.org, linux-kernel@vger.kernel.org
References: <20040214165037.GA15985@lst.de> <Pine.LNX.4.58.0402140857520.13436@home.osdl.org> <20040214175813.GI8858@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <20040214175813.GI8858@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 14, 2004 at 05:58:13PM +0000, viro@parcelfarce.linux.theplanet.=
co.uk wrote:
> > Because if James can't trickle them in, somebody else will have to. Tha=
t's=20
> > what happened with the new radeon driver.
>=20
> Where's James' repository, BTW?  I could help with split-and-reorder on
> that one...

bk://fbdev.bkbits.net/fbdev-2.6


--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQFALn231K+teJFxZ9wRAmt3AJ9r/A3RXvhV5ga5WuCkZGNmqjXOXwCfYZXc
Ft1mcVh3gxflYKl0JGGEQkc=
=Yrjo
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
