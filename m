Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261721AbSLBJTY>; Mon, 2 Dec 2002 04:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261742AbSLBJTY>; Mon, 2 Dec 2002 04:19:24 -0500
Received: from port326.ds1-brh.adsl.cybercity.dk ([217.157.160.207]:23161 "EHLO
	mail.jaquet.dk") by vger.kernel.org with ESMTP id <S261721AbSLBJTX>;
	Mon, 2 Dec 2002 04:19:23 -0500
Date: Mon, 2 Dec 2002 10:26:45 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.23-rc2 & an MCE
Message-ID: <20021202102645.A20062@jaquet.dk>
References: <20021126220459.GA229@elf.ucw.cz> <Pine.LNX.4.33L2.0212011838160.25551-100000@dragon.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33L2.0212011838160.25551-100000@dragon.pdx.osdl.net>; from rddunlap@osdl.org on Sun, Dec 01, 2002 at 06:39:41PM -0800
X-PGP-Key: http://www.jaquet.dk/rasmus/pubkey.asc
X-PGP-Fingerprint: 925A 8E4B 6D63 1C22 BFB9  29CF 9592 4049 9E9E 26CE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 01, 2002 at 06:39:41PM -0800, Randy.Dunlap wrote:
> | > Machine Check Exception: 000000000000004
> | > Bank 4: b200000000040151
> | > Kernel panic: CPU context corrupt
>=20
> Rasmus,
>=20
> If you haven't already done so, you should check out the
> MCE decoder from Dave Jones at
>   http://www.codemonkey.org.uk/cruft/parsemce.c/
>=20

That gave me:=20

Status: (4) Machine Check in progress.
Restart IP invalid.

Not sure what to make of that, though. Further comments
always welcome. And thanks for the pointer.

Regards,
  Rasmus

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE96ydVlZJASZ6eJs4RAhoDAJ9uqcREGktZBMrlb4b3+mwWcqHGvACfV6tK
6BFn+3yujwtze7+6Y3VvgUk=
=9HTn
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
