Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282481AbRLSSsH>; Wed, 19 Dec 2001 13:48:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282489AbRLSSr4>; Wed, 19 Dec 2001 13:47:56 -0500
Received: from adsl-64-109-202-217.dsl.milwwi.ameritech.net ([64.109.202.217]:43513
	"EHLO alphaflight.d6.dnsalias.org") by vger.kernel.org with ESMTP
	id <S282481AbRLSSrq>; Wed, 19 Dec 2001 13:47:46 -0500
Date: Wed, 19 Dec 2001 12:47:45 -0600
From: "M. R. Brown" <mrbrown@0xd6.org>
To: nbecker@fred.net
Cc: Benoit Poulot-Cazajous <poulot@ifrance.com>, linux-kernel@vger.kernel.org
Subject: Re: On K7, -march=k6 is good (Was Re: Why no -march=athlon?)
Message-ID: <20011219184745.GF19236@0xd6.org>
In-Reply-To: <x88r8ptki37.fsf@rpppc1.hns.com> <20011217174020.GA24772@0xd6.org> <lnitb3drx6.fsf_-_@walhalla.agaha> <20011219175616.GD19236@0xd6.org> <x88itb3njfr.fsf@rpppc1.hns.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NklN7DEeGtkPCoo3"
Content-Disposition: inline
In-Reply-To: <x88itb3njfr.fsf@rpppc1.hns.com>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NklN7DEeGtkPCoo3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* nbecker@fred.net <nbecker@fred.net> on Wed, Dec 19, 2001:

> >>>>> "M" =3D=3D M R Brown <mrbrown@0xd6.org> writes:
>=20
>=20
>     M> Curious, what happens when you compile using gcc 3.0.1 against
>     M> -march=3Dathlon?
>=20
> Is it safe to use gcc-3.0.2 to compile the kernel?

Absolutely not.  There was at least one reported ICE (internal compiler
error) with drivers/net/8139too.c.  Stick to the 2.95.x series.

M. R.

--NklN7DEeGtkPCoo3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE8IODRaK6pP/GNw0URAuS0AJ9ytcR9oy3MqXqFSscYQhg58uhtYwCgrEiO
U2kR7VWoIbqJvVRBGC3/iDc=
=SIJz
-----END PGP SIGNATURE-----

--NklN7DEeGtkPCoo3--
