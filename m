Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261385AbUJXI1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbUJXI1h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 04:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbUJXI1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 04:27:36 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:15545 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S261385AbUJXI1d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 04:27:33 -0400
Date: Sun, 24 Oct 2004 10:24:30 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: "Martin Schlemmer [c]" <azarah@nosferatu.za.org>
Cc: Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable? [u]
Message-ID: <20041024082430.GB11655@thundrix.ch>
References: <4176E08B.2050706@techsource.com> <1098310747.15115.64.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lEGEL1/lMxI0MVQ2"
Content-Disposition: inline
In-Reply-To: <1098310747.15115.64.camel@nosferatu.lan>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lEGEL1/lMxI0MVQ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Salut,

On Thu, Oct 21, 2004 at 12:19:07AM +0200, Martin Schlemmer [c] wrote:
> > (3) How do you feel about the choice of neglecting 3D performance as a=
=20
> > priority?  How important is 3D performance?  In what cases is it not?
>=20
> Yeah, I think it is important - just for decent performance in
> gnome/kde, you need a card with accel RENDER support, as well as XV/GL
> for video.  Not to talk about those of us that are heavy gamers, or like
> me who like my ut2004/quake3/nvn once or twice a week.

OpenGL should be  enough to get RENDER working. The  rest may be based
on.

> The reality  of the issue  is just while  I love my linux,  I rather
> taint my kernel than crappy X performance or no gaming now and then.

The NVidia  driver hangs my system  after around 10 minutes,  and if I
write additional media drivers and other things, I sometimes end up with

if (ptr)
	ptr->blah(ptr);

failing with ptr being dereferenced as a NULL pointer, which shouldn't
happen as I just checked it.

To  people developing  the  kernels, NVidia  and  other closed  source
drivers are desasterous,  as you can't seem to find  out what the hell
they're doing, apart from graphics.

			    Tonnerre

--lEGEL1/lMxI0MVQ2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD8DBQFBe2a9/4bL7ovhw40RAojiAKClukGeOxhTeWo9mrhPoKlBTZsyjgCgr4Wn
4WSVWf6WXM9g0OQAFFYZF88=
=tJSS
-----END PGP SIGNATURE-----

--lEGEL1/lMxI0MVQ2--
