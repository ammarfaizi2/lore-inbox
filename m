Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbTFXKlw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 06:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261852AbTFXKlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 06:41:52 -0400
Received: from p164.ats40.donpac.ru ([217.107.128.164]:54430 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S261845AbTFXKlu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 06:41:50 -0400
Date: Tue, 24 Jun 2003 14:55:54 +0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] correct mail addresses for visws support
Message-ID: <20030624105554.GF9679@pazke>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cpvLTH7QU4gwfq3S"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Andrey Panin <pazke@donpac.ru>
X-Spam-Score: -10.2 (----------)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cpvLTH7QU4gwfq3S
Content-Type: multipart/mixed; boundary="ZRyEpB+iJ+qUx0kp"
Content-Disposition: inline


--ZRyEpB+iJ+qUx0kp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

this trivial patch changes mailing list address for visws
subarch support along with some occurences of my old
email addresses. Please apply.

Best regards.

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--ZRyEpB+iJ+qUx0kp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch-pazke@donpac.ru"
Content-Transfer-Encoding: quoted-printable

diff -urN -X /usr/share/dontdiff linux-2.5.73.vanilla/MAINTAINERS linux-2.5=
=2E73/MAINTAINERS
--- linux-2.5.73.vanilla/MAINTAINERS	2003-06-24 08:24:09.000000000 +0400
+++ linux-2.5.73/MAINTAINERS	2003-06-24 08:26:55.000000000 +0400
@@ -1628,8 +1628,8 @@
=20
 SGI VISUAL WORKSTATION 320 AND 540
 P:	Andrey Panin
-M:	pazke@orbita1.ru
-L:	linux-visws@lists.sf.net
+M:	pazke@donpac.ru
+L:	linux-visws-devel@lists.sf.net
 W:	http://linux-visws.sf.net
 S:	Maintained for 2.5.
=20
diff -urN -X /usr/share/dontdiff linux-2.5.73.vanilla/drivers/ide/ide-pnp.c=
 linux-2.5.73/drivers/ide/ide-pnp.c
--- linux-2.5.73.vanilla/drivers/ide/ide-pnp.c	2003-03-05 11:53:26.00000000=
0 +0300
+++ linux-2.5.73/drivers/ide/ide-pnp.c	2003-06-24 08:27:46.000000000 +0400
@@ -4,7 +4,7 @@
  * This file provides autodetection for ISA PnP IDE interfaces.
  * It was tested with "ESS ES1868 Plug and Play AudioDrive" IDE interface.
  *
- * Copyright (C) 2000 Andrey Panin <pazke@orbita.don.sitek.net>
+ * Copyright (C) 2000 Andrey Panin <pazke@donpac.ru>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
diff -urN -X /usr/share/dontdiff linux-2.5.73.vanilla/drivers/serial/8250_p=
ci.c linux-2.5.73/drivers/serial/8250_pci.c
--- linux-2.5.73.vanilla/drivers/serial/8250_pci.c	2003-05-27 14:47:40.0000=
00000 +0400
+++ linux-2.5.73/drivers/serial/8250_pci.c	2003-06-24 08:28:16.000000000 +0=
400
@@ -322,7 +322,7 @@
  * hope) because it doesn't touch EEPROM settings to prevent conflicts
  * with other OSes (like M$ DOS).
  *
- *  SIIG support added by Andrey Panin <pazke@mail.tp.ru>, 10/1999
+ *  SIIG support added by Andrey Panin <pazke@donpac.ru>, 10/1999
  *=20
  * There is two family of SIIG serial cards with different PCI
  * interface chip and different configuration methods:

--ZRyEpB+iJ+qUx0kp--

--cpvLTH7QU4gwfq3S
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE++C46by9O0+A2ZecRAqN9AKC2US8UE0dM4xWx2iruno5knti04ACg4A/X
BK3aXubd905tp9lovQc4R/Y=
=Gtqw
-----END PGP SIGNATURE-----

--cpvLTH7QU4gwfq3S--
