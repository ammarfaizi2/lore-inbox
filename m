Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261463AbTCOPOl>; Sat, 15 Mar 2003 10:14:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261464AbTCOPOl>; Sat, 15 Mar 2003 10:14:41 -0500
Received: from B5447.pppool.de ([213.7.84.71]:52609 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id <S261463AbTCOPOk>; Sat, 15 Mar 2003 10:14:40 -0500
Subject: Re: 2.5.64-ac3: Crash in ide_init_queue
From: Daniel Egger <degger@fhm.edu>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <20030314212510.GE791@suse.de>
References: <1047676410.7452.34.camel@sonja>  <20030314212510.GE791@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-a7xlGLby0dSyPJ5E9gqU"
Organization: 
Message-Id: <1047741940.10690.1.camel@sonja>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 15 Mar 2003 16:25:41 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-a7xlGLby0dSyPJ5E9gqU
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Fre, 2003-03-14 um 22.25 schrieb Jens Axboe:

> using ide tcq?

It's compiled into the kernel but unused since there's no harddrive in
the machine. I'll remove it from the config and retry.

--=20
Servus,
       Daniel

--=-a7xlGLby0dSyPJ5E9gqU
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+c0X0chlzsq9KoIYRApgkAKCGXtnihOOqIK5gD0s2OUO17IfixACg3LUO
V5lqP9oNTIwJiroW4lT2YI8=
=qaOU
-----END PGP SIGNATURE-----

--=-a7xlGLby0dSyPJ5E9gqU--

