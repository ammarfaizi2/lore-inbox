Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267989AbUHSATE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267989AbUHSATE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 20:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267967AbUHSATE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 20:19:04 -0400
Received: from viriato2.servicios.retecal.es ([212.89.0.45]:59825 "EHLO
	viriato2.servicios.retecal.es") by vger.kernel.org with ESMTP
	id S267989AbUHSASy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 20:18:54 -0400
Message-ID: <4123F1E6.2080308@hispalinux.es>
Date: Thu, 19 Aug 2004 02:18:46 +0200
From: =?ISO-8859-1?Q?Ram=F3n_Rey_Vicente?= <ramon.rey@hispalinux.es>
User-Agent: Mozilla Thunderbird 0.7.2 (X11/20040714)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: akpm@osdl.org
Subject: [PATCH] Firmware Loader is orphan
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5AC2C0AB6C352CD94764EB23"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5AC2C0AB6C352CD94764EB23
Content-Type: multipart/mixed;
 boundary="------------030001090603060008040701"

This is a multi-part message in MIME format.
--------------030001090603060008040701
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Hello.

The author and maintainer of the firmware loader died on May. I think 
this little piece is very important for the kernel. Anybody is taking 
care of firmware loader?
-- 
Ramón Rey Vicente       <ramon dot rey at hispalinux dot es>
jabber ID               <rreylinux at jabber dot org>
Huella GPG - 0BC2 8014 2445 51E8 DE87  C888 C385 A9D3 9F28 E377
---------------------------------------------------------------
	http://augcyl.org/planet/
---------------------------------------------------------------

--------------030001090603060008040701
Content-Type: text/plain;
 name="firmware_loader_orphan.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="firmware_loader_orphan.patch"

--- linux-2.6-rrey/MAINTAINERS.orig	2004-08-19 01:57:52.405537120 +0200
+++ linux-2.6-rrey/MAINTAINERS	2004-08-19 02:05:25.001988245 +0200
@@ -822,10 +822,8 @@
 S:	Maintained
 
 FIRMWARE LOADER (request_firmware)
-P:	Manuel Estrada Sainz
-M:	ranty@debian.org
 L:	linux-kernel@vger.kernel.org
-S:	Maintained
+S:	Orphan
 
 FPU EMULATOR
 P:	Bill Metzenthen

--------------030001090603060008040701--

--------------enig5AC2C0AB6C352CD94764EB23
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBI/Hqw4Wp058o43cRAtKsAKDVaq5iH4gsYqp8flq+el1s4eSe5QCgvdNE
XGtYcpAsXL97F3I02uuvTBQ=
=8fjp
-----END PGP SIGNATURE-----

--------------enig5AC2C0AB6C352CD94764EB23--
