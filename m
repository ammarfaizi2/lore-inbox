Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270587AbUJUBdB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270587AbUJUBdB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 21:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270619AbUJUBax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 21:30:53 -0400
Received: from zlynx.org ([199.45.143.209]:30213 "EHLO 199.45.143.209")
	by vger.kernel.org with ESMTP id S270587AbUJUBZa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 21:25:30 -0400
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
From: Zan Lynx <zlynx@acm.org>
To: Timothy Miller <theosib@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041020234819.23232.qmail@web40706.mail.yahoo.com>
References: <20041020234819.23232.qmail@web40706.mail.yahoo.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-cppaWZeVP1Bd3okGg9aa"
Date: Wed, 20 Oct 2004 19:25:21 -0600
Message-Id: <1098321921.4215.30.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-cppaWZeVP1Bd3okGg9aa
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-10-20 at 16:48 -0700, Timothy Miller wrote:
> I'm posting from home, so this won't look right.  Sorry.
>=20
> Anyhow, Andre Eisenbach said this:
>=20
> >>>
> If the graphics card mostly supports 2D initially, it's really not
> much better then just about any off the shelf graphics card with VESA
> drivers. As in, the hardware doesn't need to be open for just that.
> Most (all?) the frustration in Linux graphics card land comes from
> unsupported/closed 3D drivers.
> <<<
>=20
> I have tried using cards with VESA drivers before, and I found it to be
> very painful.  Certainly, you can turn off certain features and get a
> reasonably useful UI experience, but dragging windows around with "show
> window contents while moving" enabled is painfully slow, even with AGP
> 4x.  Just imagine doing it over PCI.
>=20
> When it comes to desktop applications, the FIRST thing you need is good
> 2D acceleration.  In fact, that's really the ONLY thing.  OpenOffice
> does not need to use OpenGL.  GNOME doesn't need to use OpenGL.  In
> fact, for the most part, they don't bother.  There are some instances
> where they use OpenGL, but most of what a workstation user does fits
> squarely within all the functionality supplied by Xlib, which is
> entirely 2D.
[snip]

My opinion, for what its worth:

Do 3D first and only.  2D is a subset of 3D.  Implement as much of
OpenGL as you can in hardware and software can emulate any 2D interface
desired.

I agree that existing graphics cards do 2D just fine.  I can get a ATI
card for $20 that does all the 2D I need.  But 2D isn't enough for me.
I spend $400 on one Nvidia card.  Maybe I'm not the average, common
user, but users like me have the highest profit margin. :-)

I'm a pragmatic user.  I'd like full-featured Open Source drivers for my
Nvidia card but I use the binary because they work really well and for
me, (excellent_performance - closed_drivers) > (crappy_performance +
open_drivers).

If it can be done well enough to run Doom 3 in 640x480 at 20 fps for
less than $500, I'll buy one.  That's the performance level where I'd
consider sacrificing 60 fps for the open drivers.

Of course, in 5 years I'll expect 120 fps so its definitely a moving
target.
--=20
Zan Lynx <zlynx@acm.org>

--=-cppaWZeVP1Bd3okGg9aa
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBdxABG8fHaOLTWwgRAgoeAJ4zEHZQWI1CahmCYC5grpLaPVnfsgCgqXQJ
FXC8dOlfNdSkgxVvTiu4KAY=
=rUxQ
-----END PGP SIGNATURE-----

--=-cppaWZeVP1Bd3okGg9aa--

