Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314558AbSEYNoU>; Sat, 25 May 2002 09:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314571AbSEYNoT>; Sat, 25 May 2002 09:44:19 -0400
Received: from zeus.kernel.org ([204.152.189.113]:50842 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S314558AbSEYNoS>;
	Sat, 25 May 2002 09:44:18 -0400
Subject: Re: RTAI/RtLinux
From: Erwin Rol <erwin@muffin.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, RTAI users <rtai@rtai.org>
In-Reply-To: <1022333453.11811.10.camel@irongate.swansea.linux.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-Edg83aHRlFEm2STJjbG6"
X-Mailer: Ximian Evolution 1.0.5 
Date: 25 May 2002 15:42:50 +0200
Message-Id: <1022334170.15111.199.camel@rawpower>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Edg83aHRlFEm2STJjbG6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hello Alan, and the others,

First of all my mail was not meant to be a flame, if it looked like that
I apologize for that. =20

On Sat, 2002-05-25 at 15:30, Alan Cox wrote:
> On Sat, 2002-05-25 at 10:05, Erwin Rol wrote:
> > I just hope the linux developers are smart enough to not accept the
> > RTLinux into the main kernel, cause someday someone might come up with
> > the idea to write something that allows to have userspace programs to b=
e
> > hard-realtime, and than you have to stop allowing non GPL userspace
> > programs, like for example GLIB( which is LGPL).=20
>=20
GLIB should have been GLIBC, but that doesn't really mather for the
discussion.

> LGPL can be used as GPL. If you haven't even read the license do that
> before the flamewar please.
>=20

I know this, the point is that when you use the LGPL to be used as the
GPL it is not really LGPL anymore. A binary program using GLIBC depends
on the fact that GLIBC allows that (because of its LGPL license). What i
wanted to say is that "allowance" might be taken away by the patent
license.

> The RtLinux patent seems to boil down to "If you are free software we
> are free software, if you are proprietary we play in your space too,
> please pay up". Its not something I'm totally happy with but I don't
> really see how else Victor can phrase it.
>=20

IANAL, so i would not know how to phrase it. Thats why I (and several
others) asked FSMLabs to explain some of it in more clear language, and
we gave some examples (like the one in my other mail) so FSMLabs could
say if those where compliant with their license or not.=20

The big question still is where the patent "stops", and there ppl like
Eben Moglen and Victor Yodaiken have very different opinions. A lot of
other ppl try to explain how they see things, and of course those
explanations  also differ a lot, but that is just normal. =20

It is like a patent on VM management, or some other kernel internal
technique, does that mean that that patent is also has something to say
about ppl that write programs for that OS ? The same with LXRT (the
userspace part of RTAI), its implementation might fall under the patent,
but does the program that uses the LXRT services also fall under the
patent ? Than the next question , the userspace<->kernel border is
nothing "magical" in respect to patent law, so for kernel modules the
same question is true; do they implement the patent (and hence should
they comply to the license) or do they just use the services the
patented part offers.=20

I hope you can see that these are uncertainties that I (and other ppl
have) and would just liked the have cleared up without a lawsuit :-/
Even FSMLabs, and their users would provide from that, cause more ppl
can program more in a shorter time :-)=20

- Erwin
=20


--=-Edg83aHRlFEm2STJjbG6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA875TaILu3T9PlUj8RAighAKCMH0xlESmnqe06sMQ/OL6F48XZeQCgvic1
ycVR4ynFQ181BD1GOacFJGo=
=/mlf
-----END PGP SIGNATURE-----

--=-Edg83aHRlFEm2STJjbG6--
