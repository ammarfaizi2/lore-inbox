Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267435AbTBNUkZ>; Fri, 14 Feb 2003 15:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267436AbTBNUkZ>; Fri, 14 Feb 2003 15:40:25 -0500
Received: from mx.laposte.net ([213.30.181.7]:36597 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id <S267435AbTBNUkW>;
	Fri, 14 Feb 2003 15:40:22 -0500
Subject: [PATCH] 2.4.18 KT400 support
From: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
To: linux-kernel@vger.kernel.org
Cc: Toplica Tanaskovic <toptan@EUnet.yu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-/Oqu1qFcwe/nUqqG3tKl"
Organization: 
Message-Id: <1045255809.2692.9.camel@rousalka>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-1) 
Date: 14 Feb 2003 21:50:09 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/Oqu1qFcwe/nUqqG3tKl
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

	The KT400 agp ids were submitted (and included with a few bits you
missed) around 2.4.20-rc4 time. Like Dave Jones wrote, they are suitable
only for agp2 cards ATM (I get a agp3 question in my mailbox every week
or so). They are far from useless, lots of people have agp2 cards.

	If you want to do everyone a favor, post a patch to document
CONFIG_AGP_VIA is agp2 only on 2.4 right now. (If you don't I might do
it one day if only to spare Dave Jones and me a few mails until 2.5 agp3
support is backported)

	Regards,

--=20
Nicolas Mailhot

--=-/Oqu1qFcwe/nUqqG3tKl
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+TVaBI2bVKDsp8g0RAsWTAJ4++7kAT2SmvLzPINaXcbyP15OqqwCeJKE0
qiwNVy2qwfy8LCF0YJXkdvg=
=L2JY
-----END PGP SIGNATURE-----

--=-/Oqu1qFcwe/nUqqG3tKl--

