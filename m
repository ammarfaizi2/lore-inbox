Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261464AbTCOPWe>; Sat, 15 Mar 2003 10:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261469AbTCOPWd>; Sat, 15 Mar 2003 10:22:33 -0500
Received: from B5447.pppool.de ([213.7.84.71]:36738 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id <S261464AbTCOPWd>; Sat, 15 Mar 2003 10:22:33 -0500
Subject: Re: 2.5.64-ac3: Crash in ide_init_queue
From: Daniel Egger <degger@fhm.edu>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <1047741940.10690.1.camel@sonja>
References: <1047676410.7452.34.camel@sonja>  <20030314212510.GE791@suse.de>
	 <1047741940.10690.1.camel@sonja>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ucfgHsV20faVQkQf9wD4"
Organization: 
Message-Id: <1047742416.10689.3.camel@sonja>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 15 Mar 2003 16:33:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ucfgHsV20faVQkQf9wD4
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Sam, 2003-03-15 um 16.25 schrieb Daniel Egger:

> > using ide tcq?

> It's compiled into the kernel but unused since there's no harddrive in
> the machine. I'll remove it from the config and retry.

Nope, same problem without tcq.

--=20
Servus,
       Daniel

--=-ucfgHsV20faVQkQf9wD4
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+c0fQchlzsq9KoIYRAhJvAKCY+mwMUjeHo2gr53hkz448fvZFWwCfT2F/
kbIS/2dqdl2rMLuSnGN2x0A=
=ROlq
-----END PGP SIGNATURE-----

--=-ucfgHsV20faVQkQf9wD4--

