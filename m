Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267059AbTAUNi1>; Tue, 21 Jan 2003 08:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267065AbTAUNi1>; Tue, 21 Jan 2003 08:38:27 -0500
Received: from smtp.laposte.net ([213.30.181.11]:59276 "EHLO smtp.laposte.net")
	by vger.kernel.org with ESMTP id <S267059AbTAUNi0>;
	Tue, 21 Jan 2003 08:38:26 -0500
Subject: small patch for Via Pro 266T agp-support
From: Nicolas Mailhot <Nicolas.Mailhot@laposte.net>
To: Jurriaan <thunder7@xs4all.nl>
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-LlwYbrmiJ2OZcDtnXJ+V"
Organization: 
Message-Id: <1043156843.9965.8.camel@ulysse.olympe.o2t>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 21 Jan 2003 14:47:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-LlwYbrmiJ2OZcDtnXJ+V
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

1. You've forgotten the (stupid and cosmetic) bits in drm(s)
(drivers/char/drm/drm_agpsupport.h and friends)

2. Please insert your PCI id at the right place (ie keep pci ids
ordered)

See http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D103834293419740&w=3D=
2
for the full kt400 detection patch I did.

(Not that it won't work without all this, but being clean is not too
difficult)

Regards,

--=20
Nicolas Mailhot

--=-LlwYbrmiJ2OZcDtnXJ+V
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+LU9rI2bVKDsp8g0RArnfAJ9fTmTymQE1jN44ovFzl5MuvUsPpQCfVcKK
+Jbsu8+jqaAxW5MeusqZk+4=
=PKaT
-----END PGP SIGNATURE-----

--=-LlwYbrmiJ2OZcDtnXJ+V--

