Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261499AbUJXO1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261499AbUJXO1t (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 10:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbUJXO1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 10:27:49 -0400
Received: from ctb-mesg5.saix.net ([196.25.240.77]:40653 "EHLO
	ctb-mesg5.saix.net") by vger.kernel.org with ESMTP id S261498AbUJXO0n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 10:26:43 -0400
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable? [u]
From: "Martin Schlemmer [c]" <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Tonnerre <tonnerre@thundrix.ch>
Cc: Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041024082430.GB11655@thundrix.ch>
References: <4176E08B.2050706@techsource.com>
	 <1098310747.15115.64.camel@nosferatu.lan>
	 <20041024082430.GB11655@thundrix.ch>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-tOP9dfET2W1zgQVpQ00S"
Date: Sun, 24 Oct 2004 16:26:25 +0200
Message-Id: <1098627985.12420.7.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-tOP9dfET2W1zgQVpQ00S
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-10-24 at 10:24 +0200, Tonnerre wrote:
> Salut,
>=20
> On Thu, Oct 21, 2004 at 12:19:07AM +0200, Martin Schlemmer [c] wrote:
> > > (3) How do you feel about the choice of neglecting 3D performance as =
a=20
> > > priority?  How important is 3D performance?  In what cases is it not?
> >=20
> > Yeah, I think it is important - just for decent performance in
> > gnome/kde, you need a card with accel RENDER support, as well as XV/GL
> > for video.  Not to talk about those of us that are heavy gamers, or lik=
e
> > me who like my ut2004/quake3/nvn once or twice a week.
>=20
> OpenGL should be  enough to get RENDER working. The  rest may be based
> on.
>=20
> > The reality  of the issue  is just while  I love my linux,  I rather
> > taint my kernel than crappy X performance or no gaming now and then.
>=20
> The NVidia  driver hangs my system  after around 10 minutes,  and if I
> write additional media drivers and other things, I sometimes end up with
>=20
> if (ptr)
> 	ptr->blah(ptr);
>=20
> failing with ptr being dereferenced as a NULL pointer, which shouldn't
> happen as I just checked it.
>=20
> To  people developing  the  kernels, NVidia  and  other closed  source
> drivers are desasterous,  as you can't seem to find  out what the hell
> they're doing, apart from graphics.
>=20

I did not say I like it, but its better than nothing.  My system here at
home had an uptime of near 20 days before I rebooted for 2.6.9-mm1 with
nvidia driver (intel i875), but at work (nforce1) it freezes if I scroll
in gnumeric with same driver.  I guess it depends what setup.


--=20
Martin Schlemmer


--=-tOP9dfET2W1zgQVpQ00S
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBe7uRqburzKaJYLYRAro5AJ4iFHPlxle56axsYNizqGHI4bmLQwCfWFOY
CEqylZO6ILBKPtGru+HGHRk=
=k58j
-----END PGP SIGNATURE-----

--=-tOP9dfET2W1zgQVpQ00S--

