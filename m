Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263203AbSJOTYk>; Tue, 15 Oct 2002 15:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261745AbSJOTYj>; Tue, 15 Oct 2002 15:24:39 -0400
Received: from node-d-1ef6.a2000.nl ([62.195.30.246]:45550 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S261645AbSJOTYi>; Tue, 15 Oct 2002 15:24:38 -0400
Subject: Re: [Kernel 2.5] Qlogic 2x00 driver
From: Arjan van de Ven <arjanv@redhat.com>
To: Simon Roscic <simon.roscic@chello.at>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200210152120.13666.simon.roscic@chello.at>
References: <200210152120.13666.simon.roscic@chello.at>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-jvLf+qM2Y4sBmsErZDhC"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 15 Oct 2002 21:31:38 +0200
Message-Id: <1034710299.1654.4.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jvLf+qM2Y4sBmsErZDhC
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2002-10-15 at 21:20, Simon Roscic wrote:
> hi,
>=20
> as the feature freeze of 2.5 comes close, i want to ask if the driver for
> the qlogic sanblade 2200/2300 series of hba's will be included in 2.5 ...
> are there any plan's to do so ?   has it been discussed before ?
>=20
> i ask because i use those hba's together with ibm's fastt500 storage syst=
em,
> and it will be nice to have this driver in the default kernel ...
>=20
> i use version 5.36.3 of the qlogic 2x00 driver in production
> (vanilla kernel 2.4.17 + qlogic 2x00 driver v5.36.3) since may 2002
> and i never had any problems with this driver ...

Oh so you haven't notices how it buffer-overflows the kernel stack, how
it has major stack hog issues, how it keeps the io request lock (and
interrupts disabled) for a WEEK ?





--=-jvLf+qM2Y4sBmsErZDhC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9rG0ZxULwo51rQBIRAmsgAJ9ofYLN5m4oCrUzTyM0kWu+EZngLgCfV5Fp
e9cOTAatzK69SC1dAbiFhYw=
=jJgf
-----END PGP SIGNATURE-----

--=-jvLf+qM2Y4sBmsErZDhC--

