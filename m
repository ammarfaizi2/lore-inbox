Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267023AbTBHPdE>; Sat, 8 Feb 2003 10:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267027AbTBHPdE>; Sat, 8 Feb 2003 10:33:04 -0500
Received: from mx.laposte.net ([213.30.181.7]:42147 "EHLO smtp.laposte.net")
	by vger.kernel.org with ESMTP id <S267023AbTBHPdE>;
	Sat, 8 Feb 2003 10:33:04 -0500
Subject: agpgart fails with Via KT400 and GeForce 4200-8x
From: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
To: linux-kernel@vger.kernel.org
Cc: Oliver Sniehotta <oliver.sniehotta@eposte>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-BrGc/bbA3y6/BBFRmY5o"
Organization: 
Message-Id: <1044718954.1783.3.camel@rousalka>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 08 Feb 2003 16:42:34 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-BrGc/bbA3y6/BBFRmY5o
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


There is no support of  Via agp3 (agp3=3D4x,8x agp2=3D2x,4x) in 2.4 right
now. There is some code in 2.5, but right now the KT400 is strictly
agp2-only in 2.4.

The KT400 is a dual agp2/agp3 chipset.

--=20
Nicolas Mailhot

--=-BrGc/bbA3y6/BBFRmY5o
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+RSVqI2bVKDsp8g0RAgvQAKD8uS9qJB87xewFDq/rSKvWcrPWpgCdFJzJ
dVP8H2VIvBf6wO/orXHga5Q=
=n25T
-----END PGP SIGNATURE-----

--=-BrGc/bbA3y6/BBFRmY5o--

