Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262813AbTFTLX0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 07:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262930AbTFTLX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 07:23:26 -0400
Received: from B5a24.pppool.de ([213.7.90.36]:6094 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id S262813AbTFTLXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 07:23:23 -0400
Subject: Re: VIA Ezra CentaurHauls
From: Daniel Egger <degger@fhm.edu>
To: Guennadi Liakhovetski <gl@dsa-ac.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0306181205180.2967-100000@pcgl.dsa-ac.de>
References: <Pine.LNX.4.33.0306181205180.2967-100000@pcgl.dsa-ac.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-1zg9QBSYnPouJMIV0bgi"
Message-Id: <1056107518.26224.16.camel@sonja>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 20 Jun 2003 13:11:59 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-1zg9QBSYnPouJMIV0bgi
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Mit, 2003-06-18 um 16.18 schrieb Guennadi Liakhovetski:

>  / tried stepping 8. The fix was to upgrade libc. I've done this (to
> version libc6_2.3.1-16, but it didn't help. Any ideas?

IIRC there were some versions of glibc in Debian which activated the 686
and higher optimized versions for the cmov-less Ezra. A workaround is to
(re)move /usr/lib/686.

--=20
Servus,
       Daniel

--=-1zg9QBSYnPouJMIV0bgi
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+8uv+chlzsq9KoIYRArsXAJ4x6O3AJMTWgKGEYnr4MSyyEKv0/wCcCFrj
QxJHzASpq0h5iZHYDmH6IwM=
=jykp
-----END PGP SIGNATURE-----

--=-1zg9QBSYnPouJMIV0bgi--

