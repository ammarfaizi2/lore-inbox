Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261395AbVALUgC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261395AbVALUgC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 15:36:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261429AbVALU1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 15:27:20 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:57797 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261395AbVALUPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 15:15:30 -0500
Subject: Re: Cherokee Nation Posts Open Source Legisation - Invites comments
	from Community Members
From: Stephen Pollei <stephen_pollei@comcast.net>
To: root <root@mail.gadugi.org>
Cc: Valdis.Kletnieks@vt.edu, christos gentsis <christos_gentsis@yahoo.co.uk>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050112171855.GA23106@mail.gadugi.org>
References: <20050106180414.GA11597@mail.gadugi.org>
	<200501061836.j06IakHo030551@turing-police.cc.vt.edu>
	<20050106183725.GA12028@mail.gadugi.org>
	<200501061935.j06JZMq4013855@turing-police.cc.vt.edu>
	<41E4CBC3.4070302@yahoo.co.uk>
	<200501120849.j0C8nkxI000704@turing-police.cc.vt.edu> 
	<20050112171855.GA23106@mail.gadugi.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-4yNVTkXcs9e0YdTl/N7U"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 12 Jan 2005 12:17:17 -0800
Message-Id: <1105561039.974.12.camel@fury>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4yNVTkXcs9e0YdTl/N7U
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-01-12 at 09:18, root wrote:
OK I've replied to this as well at
http://www.gadugi.org/article.php?story=3D20041221121621283 ...
I think that your understanding of the implications of the GPL seem to
be dangerously flawed in some respects.
>=20
>=20
> There is no impact on the GPL and any Linux code covered under the GPL
> remains as such.  The Ga-du-gi OS is defined under the current FSF=20
> definitions as a "collective work" not a "derivative work".  So all the
> folks sending mail to LKML and gadugi.org that implies otherwise
> are out in the weeds. =20

The below should also be at the above mentioned url...

OK the extent of the fork has been mentioned.
However you should note that both the GPL and LGPL only give conditional
permission to include code licensed under those terms into "collective
works". Your code that is under "/arch" sure sounds like it is
interdependant with the rest of the kernel code. Further it is not a
"separate work" and a kernel compiled with your "arch" changes can't be
shipped into two independant separate binaries-- it forms one
inseparable whole that contains incompatibily licensed code. The GPL
doesn't give anyone permission to include code licensed under those
terms in these conditions.

It would be instructive for you to compare and contrast the GPL and the
LGPL to notice that altogether not giving permission to create
inseparable, dependent works that add restrictions was *intended*. If
the developers wanted to allow you to do what it is you are attempting
they would have choosen the LGPL or another license.

You should note that the kernel developers would like to see more
successful Linux forks -- you are in fact given an explicit license to
create forks the GPL. However that is your only license to do so and if
you choose to ignore it's boundaries after being repeatiibly and
publicly warned, then you are likely to incure civil liabilites from
being found a willful premeditated copyright infringer in a few
jurisdictions around the world.

I strongly suggest that instead of assuming that you seek competent
legal advice or take an educational seminar, read a faq or two or
otherwise education yourself to what the GPL implies.

So please instead of complaining that people are "out in the weeds" or
creating a "smoke screen". Maybe you should listen a little.

http://www.ussg.iu.edu/hypermail/linux/kernel/0501.1/1425.html
http://www.fsf.org/licenses/gpl.txt
http://www.fsf.org/licenses/lgpl.txt
http://patron.fsf.org/course-offering.html
http://www.fsf.org/licenses/gpl-faq.html

--=20
http://dmoz.org/profiles/pollei.html
http://sourceforge.net/users/stephen_pollei/
http://www.orkut.com/Profile.aspx?uid=3D2455954990164098214
http://stephen_pollei.home.comcast.net/
GPG Key fingerprint =3D EF6F 1486 EC27 B5E7 E6E1  3C01 910F 6BB5 4A7D 9677

--=-4yNVTkXcs9e0YdTl/N7U
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQBB5YXMkQ9rtUp9lncRAqdZAJ9zZRDhqg1v7Osq7xwkGjaeduyVrwCfQ57/
Eosj+SOkjPc9wkATdDP4314=
=KSsk
-----END PGP SIGNATURE-----

--=-4yNVTkXcs9e0YdTl/N7U--

