Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265245AbSJWVhi>; Wed, 23 Oct 2002 17:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265244AbSJWVhi>; Wed, 23 Oct 2002 17:37:38 -0400
Received: from [62.81.160.127] ([62.81.160.127]:20237 "EHLO smtp07.eresmas.com")
	by vger.kernel.org with ESMTP id <S265246AbSJWVhd>;
	Wed, 23 Oct 2002 17:37:33 -0400
Subject: drivers/video/riva/fbdev.c error in 2.5.44-ac1
From: "Jorge Bernal \"Koke\"" <501545@ingtz.unizar.es>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-riN7vyrlEgctF5FEV94x"
X-Mailer: Ximian Evolution 1.0.5 
Date: 23 Oct 2002 23:38:44 +0200
Message-Id: <1035409140.1453.20.camel@tuxland.servebeer.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-riN7vyrlEgctF5FEV94x
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I got this error when compiling 2.5.44-ac1:=20

drivers/video/riva/fbdev.c: In function `riva_set_dispsw':=20
drivers/video/riva/fbdev.c:665: structure has no member named `type'=20
drivers/video/riva/fbdev.c:666: structure has no member named `type_aux'
drivers/video/riva/fbdev.c:667: structure has no member named `ypanstep'
drivers/video/riva/fbdev.c:668: structure has no member named
`ywrapstep'=20
drivers/video/riva/fbdev.c:677: structure has no member named
`line_length'=20
drivers/video/riva/fbdev.c:678: structure has no member named `visual'=20
drivers/video/riva/fbdev.c:686: structure has no member named
`line_length'=20
drivers/video/riva/fbdev.c:687: structure has no member named `visual'=20
drivers/video/riva/fbdev.c:695: structure has no member named
`line_length'=20
drivers/video/riva/fbdev.c:696: structure has no member named `visual'=20
drivers/video/riva/fbdev.c: In function `rivafb_get_fix':=20
drivers/video/riva/fbdev.c:1294: structure has no member named `type'=20
drivers/video/riva/fbdev.c:1295: structure has no member named
`type_aux'=20
drivers/video/riva/fbdev.c:1296: structure has no member named `visual'=20
drivers/video/riva/fbdev.c:1302: structure has no member named
`line_length'=20
drivers/video/riva/fbdev.c: In function `rivafb_pan_display':=20
drivers/video/riva/fbdev.c:1611: structure has no member named
`line_length'=20
drivers/video/riva/fbdev.c:1586: warning: `base' might be used
uninitialized in this function=20
drivers/video/riva/fbdev.c: At top level:=20
drivers/video/riva/fbdev.c:1748: unknown field `fb_get_fix' specified in
initializer=20
drivers/video/riva/fbdev.c:1748: warning: initialization from
incompatible pointer type=20
drivers/video/riva/fbdev.c:1749: unknown field `fb_get_var' specified in
initializer=20
drivers/video/riva/fbdev.c:1749: warning: initialization from
incompatible pointer type=20
make[3]: *** [drivers/video/riva/fbdev.o] Error 1=20
make[2]: *** [drivers/video/riva] Error 2=20
make[1]: *** [drivers/video] Error 2=20
make: *** [drivers] Error 2=20

--=20
Jorge Bernal (Koke)
The software required Win95 or better, so I installed Linux
ICQ#: 63593654
MSN: koke_jb

--=-riN7vyrlEgctF5FEV94x
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje esta firmada digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA9txbk83ZStI0d58IRAvmuAJ4jEw1zB9921ftXPDFwJnnlzbkD6QCg0Mox
5NuGS0JVPNKTjrEFkh4g4dQ=
=zVnz
-----END PGP SIGNATURE-----

--=-riN7vyrlEgctF5FEV94x--

