Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261733AbTBFJtl>; Thu, 6 Feb 2003 04:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265863AbTBFJtl>; Thu, 6 Feb 2003 04:49:41 -0500
Received: from adsl-67-123-8-233.dsl.pltn13.pacbell.net ([67.123.8.233]:3296
	"EHLO influx.triplehelix.org") by vger.kernel.org with ESMTP
	id <S261733AbTBFJtk>; Thu, 6 Feb 2003 04:49:40 -0500
Date: Thu, 6 Feb 2003 01:58:46 -0800
To: Joeri Belis <joeri.belis@nollekens.be>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: how can i see if i am using a module or compiled in kernel?
Message-ID: <20030206095846.GA24461@triplehelix.org>
References: <011c01c2cdc0$ae05dd30$15c809c6@PCJOERI01>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
In-Reply-To: <011c01c2cdc0$ae05dd30$15c809c6@PCJOERI01>
User-Agent: Mutt/1.5.3i
From: Joshua Kwan <joshk@triplehelix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 06, 2003 at 10:18:15AM +0100, Joeri Belis wrote:
> Hi,
>=20
> How can i see if serial.o is being used or that i have this compiled in t=
he
> kernel?

Use dmesg to look for stuff that has been compiled into the kernel and=20
lsmod (typically /sbin/lsmod) for loaded modules.

Regards
Josh

--=20
New PGP public key: 0x27AFC3EE
(doesn't expire, yay)

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+QjHWT2bz5yevw+4RAsMDAJ9PzzPnNg2+Ui5JeLtABsuIJRCOMwCbBnlf
mldMdJcPNq1vB/J8FGDiluo=
=J/Jo
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
