Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283724AbRLSTWK>; Wed, 19 Dec 2001 14:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285412AbRLSTWA>; Wed, 19 Dec 2001 14:22:00 -0500
Received: from adsl-64-109-202-217.dsl.milwwi.ameritech.net ([64.109.202.217]:3580
	"EHLO alphaflight.d6.dnsalias.org") by vger.kernel.org with ESMTP
	id <S283724AbRLSTVm>; Wed, 19 Dec 2001 14:21:42 -0500
Date: Wed, 19 Dec 2001 13:21:40 -0600
From: "M. R. Brown" <mrbrown@0xd6.org>
To: J Sloan <jjs@lexus.com>
Cc: nbecker@fred.net, Benoit Poulot-Cazajous <poulot@ifrance.com>,
        linux-kernel@vger.kernel.org
Subject: Re: On K7, -march=k6 is good (Was Re: Why no -march=athlon?)
Message-ID: <20011219192140.GG19236@0xd6.org>
In-Reply-To: <x88r8ptki37.fsf@rpppc1.hns.com> <20011217174020.GA24772@0xd6.org> <lnitb3drx6.fsf_-_@walhalla.agaha> <20011219175616.GD19236@0xd6.org> <x88itb3njfr.fsf@rpppc1.hns.com> <20011219184745.GF19236@0xd6.org> <3C20E1F8.9C8D2825@lexus.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cPi+lWm09sJ+d57q"
Content-Disposition: inline
In-Reply-To: <3C20E1F8.9C8D2825@lexus.com>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cPi+lWm09sJ+d57q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* J Sloan <jjs@lexus.com> on Wed, Dec 19, 2001:

> "M. R. Brown" wrote:
>=20
> > * nbecker@fred.net <nbecker@fred.net> on Wed, Dec 19, 2001:
> >
> > > Is it safe to use gcc-3.0.2 to compile the kernel?
> >
> > Absolutely not.  There was at least one reported ICE (internal compiler
> > error) with drivers/net/8139too.c.  Stick to the 2.95.x series.
>=20
> BTW 2.96 is fine also -
>=20

There is no 2.96 except the Red Hat maintained version of GCC, but if
you're saying that Red Hat's compiler works, more power to you.

M. R.

--cPi+lWm09sJ+d57q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE8IOjEaK6pP/GNw0URAh1tAJ40ioYJS71E58ij3tHKUL/+aVc5BwCffwNw
qQqBYqS604PtvKMQ+B6uhzg=
=k/VQ
-----END PGP SIGNATURE-----

--cPi+lWm09sJ+d57q--
