Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261309AbUKSIph@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbUKSIph (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 03:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbUKSIpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 03:45:36 -0500
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:49842 "EHLO
	albatross.madduck.net") by vger.kernel.org with ESMTP
	id S261307AbUKSIpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 03:45:13 -0500
Date: Fri, 19 Nov 2004 09:44:58 +0100
From: martin f krafft <madduck@madduck.net>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9 nfsd crashing often
Message-ID: <20041119084458.GA1191@cirrus.madduck.net>
Mail-Followup-To: Neil Brown <neilb@cse.unsw.edu.au>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20041118173504.GA24187@cirrus.madduck.net> <16797.31183.853387.514386@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
In-Reply-To: <16797.31183.853387.514386@cse.unsw.edu.au>
X-OS: Debian GNU/Linux 3.1 kernel 2.6.8-cirrus i686
X-Mailer: Mutt 1.5.6+20040907i (CVS)
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
X-Spamtrap: madduck.bogus@madduck.net
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Neil Brown <neilb@cse.unsw.edu.au> [2004.11.19.0542 +0100]:
> >   Call Trace:
> >   [<c0166197>] __lookup_hash+0xa7/0xe0
>=20
> Looks like i_op->lookup =3D=3D NULL, and I don't think nfsd could do that.
>=20
> What filesystem are you using?

XFS.

Thanks for following up!

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
invalid/expired pgp subkeys? use subkeys.pgp.net as keyserver!
spamtraps: madduck.bogus@madduck.net
=20
"moderation is a fatal thing. enough is as bad as a meal. more than
 enough is as good as a feast."
                                                        -- oscar wilde

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBnbKKIgvIgzMMSnURApAvAJ4hXrJ+7VvIFLqdffZphVqNl5IAlACfU0Nh
4xqGDp3dtaOwoXnnipA0bCM=
=6tdo
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
