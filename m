Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267607AbTBKLja>; Tue, 11 Feb 2003 06:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267636AbTBKLja>; Tue, 11 Feb 2003 06:39:30 -0500
Received: from coruscant.franken.de ([193.174.159.226]:37060 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S267607AbTBKLj2>; Tue, 11 Feb 2003 06:39:28 -0500
Date: Tue, 11 Feb 2003 12:45:29 +0100
From: Harald Welte <laforge@gnumonks.org>
To: "Leonard Milcin, Jr" <thervoy@post.pl>
Cc: "Luck, Tony" <tony.luck@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [FWD: NAT counting]
Message-ID: <20030211114529.GH24861@sunbeam.de.gnumonks.org>
References: <DD755978BA8283409FB0087C39132BD1A07CC8@fmsmsx404.fm.intel.com> <3E48AB27.20203@post.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CjAlqr6ZqJYkDGFX"
Content-Disposition: inline
In-Reply-To: <3E48AB27.20203@post.pl>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux sunbeam 2.4.20-nfpom
X-Date: Today is Boomtime, the 37th day of Chaos in the YOLD 3169
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CjAlqr6ZqJYkDGFX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2003 at 08:49:59AM +0100, Leonard Milcin, Jr wrote:
> Luck, Tony wrote:
> > (...)
> > The fact that someone can deduce how many hosts are hidden behind
> > a NAT gateway may, or may not, be a bug ... depending on whether you
> > think that the NAT is supposed to keep this number a secret.  But there
> > (...)
>=20
> Sometimes it is desirable to hide the true number of hosts behind the=20
> NAT. For example in home-made Linux NAT Gateways where few people share=
=20
> the same internet connections even if ISP doesn't allow sharing=20
> connection ;)

No doubt.  But as I initially stated: I don't want to do this by
default.  We will give the user a choice [by means of an IPID target in
the mangle table].

--=20
- Harald Welte <laforge@gnumonks.org>               http://www.gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"If this were a dictatorship, it'd be a heck of a lot easier, just so long
 as I'm the dictator."  --  George W. Bush Dec 18, 2000

--CjAlqr6ZqJYkDGFX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE+SOJZXaXGVTD0i/8RAlNmAJwKC6bkE/lbW1Lq7ZzZ9y79kIgQTACfe+Zt
kjGdZP2WgKSq9dR+SH7JR3M=
=Xgyt
-----END PGP SIGNATURE-----

--CjAlqr6ZqJYkDGFX--
