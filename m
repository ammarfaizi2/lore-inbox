Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279484AbRJ2UsW>; Mon, 29 Oct 2001 15:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279488AbRJ2UsN>; Mon, 29 Oct 2001 15:48:13 -0500
Received: from [64.133.52.190] ([64.133.52.190]:2566 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S279484AbRJ2Ur5>; Mon, 29 Oct 2001 15:47:57 -0500
Date: Mon, 29 Oct 2001 12:47:53 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: J Sloan <jjs@lexus.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Nasty suprise with uptime
Message-ID: <20011029124753.F21285@one-eyed-alien.net>
Mail-Followup-To: J Sloan <jjs@lexus.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <E15yJD1-0003uO-00@the-village.bc.nu> <3BDDBE89.397E42C0@lexus.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="Mjqg7Yu+0hL22rav"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BDDBE89.397E42C0@lexus.com>; from jjs@lexus.com on Mon, Oct 29, 2001 at 12:39:37PM -0800
Organization: One Eyed Alien Networks
X-Copyright: (C) 2001 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Mjqg7Yu+0hL22rav
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

No, but there are a couple of applicable Linux policies:
(1) If it breaks, you get to keep both halves.
(2) If it's broken, fix it yourself.

:)

Matt

On Mon, Oct 29, 2001 at 12:39:37PM -0800, J Sloan wrote:
> Alan Cox wrote:
>=20
> > > and received a nasty surprise. The uptime, which had been 496+ days
> > > on Friday, was back down to a few hours. I was ready to lart somebody
> > > with great vigor when I realized the uptime counter had simply wrapped
> > > around.
> > >
> > > So, I thought to myself, at least the 2.4 kernels on our new boxes wo=
n't
> >
> > It wraps at 496 days. The drivers are aware of it and dont crash the box
>=20
> Yes, and these boxes are still running fine - other
> than showing some processes that were started
> in the year 2003... but DAMN, what an eyesore -
> uptime ruined as far as anybody can tell, times
> and dates no longer making any sense.
>=20
> So, is there an implicit Linux policy to upgrade
> the distro, or at least the kernel, every 496 days
> whether it needs it or not?
>=20
> ;-)
>=20
> cu
>=20
> jjs
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

NYET! The evil stops here!
					-- Pitr
User Friendly, 6/22/1998

--Mjqg7Yu+0hL22rav
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD4DBQE73cB5z64nssGU+ykRAvQDAJd6EKjuG+qQQCdb9BsbJNhm7UBmAKCGhnd0
Lkvn1edbZBbvjjs2zlEiHg==
=/8WO
-----END PGP SIGNATURE-----

--Mjqg7Yu+0hL22rav--
