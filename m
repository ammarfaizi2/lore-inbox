Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263015AbTCWKkT>; Sun, 23 Mar 2003 05:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263016AbTCWKkT>; Sun, 23 Mar 2003 05:40:19 -0500
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:11759 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP
	id <S263015AbTCWKkS>; Sun, 23 Mar 2003 05:40:18 -0500
Subject: Re: [PATCH] parallel port
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20030323082239.GE6940@fs.tum.de>
References: <200303230000.h2N00nZX020752@hraefn.swansea.linux.org.uk>
	 <Pine.LNX.4.44.0303221919160.2959-100000@home.transmeta.com>
	 <20030323082239.GE6940@fs.tum.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-OJOv+67Clr1KKOJtZ/nA"
Organization: Red Hat, Inc.
Message-Id: <1048416614.1498.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 23 Mar 2003 11:50:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-OJOv+67Clr1KKOJtZ/nA
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-03-23 at 09:22, Adrian Bunk wrote:
> On Sat, Mar 22, 2003 at 07:21:11PM -0800, Linus Torvalds wrote:
>=20
> > This one causes=20
> >=20
> > 	drivers/parport/parport_pc.c:2273: warning: implicit declaration of fu=
nction `rename_region'
> > 	drivers/built-in.o(.text+0x77a8c): In function `parport_pc_probe_port'=
:
> > 	: undefined reference to `rename_region'
> >=20
> > for me. I think I complained about that once before already. Tssk, tssk=
.
>=20
> It's perhaps a silly question:
> Why did you use a "do ... while  (0)" in your fix?

http://www.kernelnewbies.org/faq/index.php3#dowhile

more details there

--=-OJOv+67Clr1KKOJtZ/nA
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+fZFlxULwo51rQBIRAlSFAJ97qeQpJruTcPhJ+k+ZTh2j35BqnACgjKmV
sPM1ZOy2c504U194K890Pyo=
=BE58
-----END PGP SIGNATURE-----

--=-OJOv+67Clr1KKOJtZ/nA--
