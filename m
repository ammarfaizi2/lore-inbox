Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261165AbSJHPWN>; Tue, 8 Oct 2002 11:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261186AbSJHPWN>; Tue, 8 Oct 2002 11:22:13 -0400
Received: from node-d-1ef6.a2000.nl ([62.195.30.246]:34030 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S261165AbSJHPWM>; Tue, 8 Oct 2002 11:22:12 -0400
Subject: Re: FW: 2.4.9/2.4.18 max kernel allocation size
From: Arjan van de Ven <arjanv@redhat.com>
To: Ofer Raz <oraz@checkpoint.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <027801c26ede$0f37deb0$8b705a3e@checkpoint.com>
References: <027801c26ede$0f37deb0$8b705a3e@checkpoint.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-laWwJqw5GS1nD4EBHp79"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 08 Oct 2002 17:27:11 +0200
Message-Id: <1034090862.2172.1.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-laWwJqw5GS1nD4EBHp79
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2002-10-08 at 17:19, Ofer Raz wrote:
>=20
>=20
> -----Original Message-----
> From: Ofer Raz [mailto:oraz@checkpoint.com]
> Sent: Tuesday, October 08, 2002 2:19 PM
> To: 'linux-kernel-owner@vger.kernel.org'
> Subject: 2.4.9/2.4.18 max kernel allocation size
>=20
>=20
> I'm trying to obtain the largest kernel allocation possible using vmalloc

anything you can get > 64Mb on x86 is pure luck (eg you are lucky in
your choice of PCI cards)

>=20
> Any idea how can I make the kernel allocation on 2.4.18-10 larger than 85=
MB
> on 1GB machine?
>
Please give a pointer to the source of your code so that everybody here
can see what you are trying to do and how to fix it to do it different


--=-laWwJqw5GS1nD4EBHp79
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9ovlPxULwo51rQBIRAnraAKCemtq2Ep6uMU7d4IHeAEJvx5x/FQCeJrUC
qsCvgMQsllR/iDF77cQ+fMs=
=85ce
-----END PGP SIGNATURE-----

--=-laWwJqw5GS1nD4EBHp79--

