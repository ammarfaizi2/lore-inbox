Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262387AbSI2ER7>; Sun, 29 Sep 2002 00:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262388AbSI2ER7>; Sun, 29 Sep 2002 00:17:59 -0400
Received: from [61.149.36.14] ([61.149.36.14]:62218 "HELO bj.soulinfo.com")
	by vger.kernel.org with SMTP id <S262387AbSI2ER6>;
	Sun, 29 Sep 2002 00:17:58 -0400
Date: Sun, 29 Sep 2002 12:14:43 +0800
From: Hu Gang <gang_hu@soul.com.cn>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [patch] Serial 1/2
Message-Id: <20020929121443.3fd93283.gang_hu@soul.com.cn>
Organization: Beijing Soul
X-Mailer: Sylpheed version 0.8.2claws28 (GTK+ 1.2.10; i386-linux-debian-i386-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary=")+s=.h4N99)tC3oC"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--)+s=.h4N99)tC3oC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello all:

This patch make serial can compile. 2.5.39
--- drivers/serial/8250.c~old	Sun Sep 29 12:06:03 2002
+++ drivers/serial/8250.c	Sun Sep 29 12:09:44 2002
@@ -31,6 +31,7 @@
 #include <linux/console.h>
 #include <linux/sysrq.h>
 #include <linux/serial_reg.h>
+#include <linux/serial.h>
 #include <linux/serialP.h>
 #include <linux/delay.h>
 


-- 
		- Hu Gang

--)+s=.h4N99)tC3oC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9ln4zPM4uCy7bAJgRAm7CAJ0VybuDOG9ZFXnvmYXQBj3nE9nimgCeL9l8
jP8GbU8rFyTcsxEC275JJIY=
=1GxT
-----END PGP SIGNATURE-----

--)+s=.h4N99)tC3oC--
