Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262972AbUERMSP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262972AbUERMSP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 08:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263184AbUERMSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 08:18:15 -0400
Received: from adsl-74-86.38-151.net24.it ([151.38.86.74]:4617 "EHLO
	gateway.milesteg.arr") by vger.kernel.org with ESMTP
	id S262972AbUERMSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 08:18:12 -0400
Date: Tue, 18 May 2004 14:18:10 +0200
From: Daniele Venzano <webvenza@libero.it>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Sis900 bug fixes 1/4
Message-ID: <20040518121810.GD23565@picchio.gall.it>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <20040518120237.GC23565@picchio.gall.it>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0lnxQi9hkpPO77W3"
Content-Disposition: inline
In-Reply-To: <20040518120237.GC23565@picchio.gall.it>
X-Operating-System: Debian GNU/Linux on kernel Linux 2.4.25-grsec
X-Copyright: Forwarding or publishing without permission is prohibited.
X-Truth: La vita e' una questione di culo, o ce l'hai o te lo fanno.
X-GPG-Fingerprint: 642A A345 1CEF B6E3 925C  23CE DAB9 8764 25B3 57ED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0lnxQi9hkpPO77W3
Content-Type: multipart/mixed; boundary="8GpibOaaTibBMecb"
Content-Disposition: inline


--8GpibOaaTibBMecb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Patch 1 of 4

Change of maintainership for the sis900 driver

The URL of a page with some informations is also added.

Any comment is highly appreciated.

--=20
-----------------------------
Daniele Venzano
Web: http://teg.homeunix.org


--8GpibOaaTibBMecb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sis900-maintainers.diff"
Content-Transfer-Encoding: quoted-printable

--- linux-2.6.6/MAINTAINERS	2004-05-18 09:03:16.000000000 +0200
+++ linux-sis900/MAINTAINERS	2004-05-18 10:29:04.000000000 +0200
@@ -1824,10 +1824,11 @@
 S:	Maintained
=20
 SIS 900/7016 FAST ETHERNET DRIVER
-P:	Ollie Lho
-M:	ollie@sis.com.tw
+P:	Daniele Venzano
+M:	webvenza@libero.it
 L:	linux-net@vger.kernel.org
-S:	Supported
+W:	http://teg.homeunix.org/sis900.html
+S:	Maintained
=20
 SIS FRAMEBUFFER DRIVER
 P:	Thomas Winischhofer

--8GpibOaaTibBMecb--

--0lnxQi9hkpPO77W3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAqf8C2rmHZCWzV+0RAp8XAJ98Q7sVH7MhxylyO9dcV+zb+u3fSACgjlew
GRRHM4DKDTbfnwgoLGl1GQg=
=5ysh
-----END PGP SIGNATURE-----

--0lnxQi9hkpPO77W3--
