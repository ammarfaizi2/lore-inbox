Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261354AbTCORVG>; Sat, 15 Mar 2003 12:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261358AbTCORVG>; Sat, 15 Mar 2003 12:21:06 -0500
Received: from B52b2.pppool.de ([213.7.82.178]:50057 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id <S261354AbTCORVF>; Sat, 15 Mar 2003 12:21:05 -0500
Subject: Re: 2.5.64-ac3: Crash in ide_init_queue
From: Daniel Egger <degger@fhm.edu>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <20030315163137.GR791@suse.de>
References: <1047676410.7452.34.camel@sonja> <20030314212510.GE791@suse.de>
	 <1047741940.10690.1.camel@sonja> <1047742416.10689.3.camel@sonja>
	 <20030315163137.GR791@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-/FDBNc6PRgqC0A7VzcyM"
Organization: 
Message-Id: <1047749489.10690.25.camel@sonja>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 15 Mar 2003 18:31:30 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/FDBNc6PRgqC0A7VzcyM
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Sam, 2003-03-15 um 17.31 schrieb Jens Axboe:

> Please double check, TCQ is the only way that ide_init_queue() would end
> up with NULL EIP.

Yep this was a nobrainer of mine. As stated in a followup mail, this
problem went away and a different IDE problem stepped up.

--=20
Servus,
       Daniel


--=-/FDBNc6PRgqC0A7VzcyM
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+c2Nxchlzsq9KoIYRAr7+AJ4rd7UhgGpUDIEUpiHVBjjSMGDjZQCgvK8B
CkgqMn1oOp/UNJ0HO2Ar+18=
=iNf0
-----END PGP SIGNATURE-----

--=-/FDBNc6PRgqC0A7VzcyM--

