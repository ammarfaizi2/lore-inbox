Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261674AbSIXNsM>; Tue, 24 Sep 2002 09:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261675AbSIXNsM>; Tue, 24 Sep 2002 09:48:12 -0400
Received: from node-d-1ef6.a2000.nl ([62.195.30.246]:32750 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S261674AbSIXNsL>; Tue, 24 Sep 2002 09:48:11 -0400
Subject: Re: hpt370 raid driver
From: Arjan van de Ven <arjanv@redhat.com>
To: Petr Slansky <slansky@usa.net>
Cc: alan@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20020924132445Z261665-8740+289@vger.kernel.org>
References: <20020924132445Z261665-8740+289@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-oQYeG72dlLiN6LjzsJZX"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 24 Sep 2002 15:55:02 +0200
Message-Id: <1032875703.2607.0.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-oQYeG72dlLiN6LjzsJZX
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2002-09-24 at 15:29, Petr Slansky wrote:
> Hi Alan!
> do you know that there is a source code of driver for HPT370 raid at the
> manufacturer web?
>=20
> http://www.highpoint-tech.com/370drivers_down.htm
> http://www.highpoint-tech.com/hpt3xx-opensource-v13.tgz
>=20
> Maybe that this can be added to the kernel, there are many motherboards o=
n the
> market with such controller onboard. Is there any poblem with this driver=
?

It's a binary only driver with some glue code.... not open source.

>=20
> As I know, hpt370 is supported only in IDE mode by kernel 2.4.18.

and in raid0 mode by hptraid

Greetings,
   Arjan van de Ven


--=-oQYeG72dlLiN6LjzsJZX
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9kG62xULwo51rQBIRAhd4AJ9hYuJpAoOrmzuh9IaOclq/cIZM+ACgoGYh
V5nCCMA/C/bMEa4IcpSQ6L0=
=ZI4e
-----END PGP SIGNATURE-----

--=-oQYeG72dlLiN6LjzsJZX--

