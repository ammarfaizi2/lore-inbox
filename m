Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261737AbVCLMnA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261737AbVCLMnA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 07:43:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261740AbVCLMnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 07:43:00 -0500
Received: from adsl-166-231.38-151.net24.it ([151.38.231.166]:22282 "HELO
	gateway.milesteg.arr") by vger.kernel.org with SMTP id S261737AbVCLMmZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 07:42:25 -0500
Date: Sat, 12 Mar 2005 13:42:21 +0100
From: Daniele Venzano <venza@brownhat.org>
To: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       NetDev <netdev@oss.sgi.com>
Subject: Maintainer change for the sis900 driver
Message-ID: <20050312124221.GA2368@gateway.milesteg.arr>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	NetDev <netdev@oss.sgi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pd0ReVV5GZGQvF3a"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Pd0ReVV5GZGQvF3a
Content-Type: multipart/mixed; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The attached patch updates the sis900 record of MAINTAINERS file.

Signed-off-by: Daniele Venzano <venza@brownhat.org>

-- 
-----------------------------
Daniele Venzano
Web: http://www.brownhat.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sis900_maintainer.diff"

--- a/MAINTAINERS	2005-03-12 11:40:46.000000000 +0100
+++ b/MAINTAINERS	2005-03-12 11:44:39.000000000 +0100
@@ -2017,10 +2017,11 @@
 S:	Maintained
 
 SIS 900/7016 FAST ETHERNET DRIVER
-P:	Ollie Lho
-M:	ollie@sis.com.tw
+P:	Daniele Venzano
+M:	venza@brownhat.org
+W:	http://www.brownhat.org/sis900.html
 L:	linux-net@vger.kernel.org
-S:	Supported
+S:	Maintained
 
 SIS FRAMEBUFFER DRIVER
 P:	Thomas Winischhofer

--6c2NcOVqGQ03X4Wi--

--Pd0ReVV5GZGQvF3a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCMuOt2rmHZCWzV+0RAtK3AJ9ksAjE51pz+JxA3hyZAhlbU+DcPACfSWeF
Tj+GrgfJj/hVHHy84hTKAFQ=
=+yWa
-----END PGP SIGNATURE-----

--Pd0ReVV5GZGQvF3a--
