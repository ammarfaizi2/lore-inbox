Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290710AbSA3Wpk>; Wed, 30 Jan 2002 17:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290709AbSA3Wpc>; Wed, 30 Jan 2002 17:45:32 -0500
Received: from mail.conwaycorp.net ([24.144.1.33]:45251 "HELO
	mail.conwaycorp.net") by vger.kernel.org with SMTP
	id <S290704AbSA3WpZ>; Wed, 30 Jan 2002 17:45:25 -0500
Date: Wed, 30 Jan 2002 16:45:23 -0600
From: Nathan Poznick <poznick@conwaycorp.net>
To: Austin Gonyou <austin@coremetrics.com>
Cc: linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Oops in bdflush with 2.4.1[4|7]-xfs
Message-ID: <20020130224523.GA26824@conwaycorp.net>
In-Reply-To: <20020130214108.GA25792@conwaycorp.net> <1012428545.12420.29.camel@UberGeek>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
In-Reply-To: <1012428545.12420.29.camel@UberGeek>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thus spake Austin Gonyou:
> Could you see if my XFS-AA patch does anything for you? There are
> changes to bdflush in it and I'd be interested to see if they go away.=20
>=20
> http://www.digitalroadkill.net/Patches/2.4.17-xfs-aa.patch.bz2

Unfortunately I can't really do to much messing around with this
machine right now, it's being used pretty heavily.  Even after bdflush
died and I needed to bounce the machine, I just about had to beat the
developers off the machine with a stick. :-)

Eric Sandeen suggested turning off DMAPI support, so I'm going to give
that a try first.  I'll go ahead and grab a copy of your patch, and
give it a try if the problem still resurfaces.

--=20
Nathan Poznick <poznick@conwaycorp.net>
PGP Key: http://drunkmonkey.org/pgpkey.txt

Boss:   You forgot to assign the result of your map!
Hacker: Dang, I'm always forgetting my assignations...
Boss:   And what's that "goto" doing there?!?
Hacker: Er, I guess my finger slipped when I was typing "getservbyport"...
Boss:   Ah well, accidents will happen.  Maybe we should have picked APL.
-- Larry Wall

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8WHeDYOn9JTETs+URAkd/AKCIelsMjVEWbL1053/kSuQKf0xhEQCgpFOo
SLJcvipfJ3FPvE1sefbA69w=
=v08z
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
