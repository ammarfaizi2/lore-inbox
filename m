Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278690AbRLQNYS>; Mon, 17 Dec 2001 08:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278932AbRLQNYJ>; Mon, 17 Dec 2001 08:24:09 -0500
Received: from point41.gts.donpac.ru ([213.59.116.41]:50952 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S278690AbRLQNXv>;
	Mon, 17 Dec 2001 08:23:51 -0500
Date: Tue, 18 Dec 2001 16:27:15 +0300
From: Andrey Panin <pazke@orbita1.ru>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] move SIIG combo cards support to parport_serial.c
Message-ID: <20011218162715.A1015@pazke.ipt>
In-Reply-To: <20011215165739.A201@pazke.ipt> <20011214135749.S14588@redhat.com> <20011214162253.A15589@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
User-Agent: Mutt/1.0.1i
In-Reply-To: <20011214162253.A15589@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Fri, Dec 14, 2001 at 04:22:53PM +0000
X-Uname: Linux pazke 2.5.1-pre11 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 14, 2001 at 04:22:53PM +0000, Russell King wrote:
> On Fri, Dec 14, 2001 at 01:57:49PM +0000, Tim Waugh wrote:
> > On Sat, Dec 15, 2001 at 04:57:39PM +0300, Andrey Panin wrote:
> >=20
> > > Untested, but compiles and should work :))
> > >=20
> > > These patches were sended to LKML some months ago, but seems like the=
y=20
> > > was lost somewhere and I can't remember any answer.
> >=20
> > I'm waiting for someone to tell me that it still works. :-)
>=20
> I'm still waiting for people to test out the new serial layer and
> report all the bugs that are bound to be in there. 8)
>=20
> One you're happy with the changes, I'll put them into my serial cvs.

Can I download it not using cvs, to test it with my PCI serial card and=20
ISAPNP modem on SMP motherboard ?

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: http://www.orbita1.ru/~pazke/AndreyPanin=
.asc
--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8H0QzBm4rlNOo3YgRAkTCAJ0ftXeya4ZfSYd0CgxNiX97gftYVgCfVf0W
FCtaYphzhps0tTcoTI/7QdQ=
=M7ht
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
