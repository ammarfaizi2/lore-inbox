Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267827AbTBRTpX>; Tue, 18 Feb 2003 14:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267849AbTBRTpX>; Tue, 18 Feb 2003 14:45:23 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:9184 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267827AbTBRTpV>;
	Tue, 18 Feb 2003 14:45:21 -0500
Subject: [TRIVIAL] mpopulate->fremap
From: Paul Larson <plars@austin.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-HB7f8+gfdcLbtvJnxvk9"
X-Mailer: Ximian Evolution 1.0.5 
Date: 18 Feb 2003 13:49:18 -0600
Message-Id: <1045597759.28493.208.camel@plars>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-HB7f8+gfdcLbtvJnxvk9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Since the current fad is to submit stuff like this, here's my
contribution...  So 2.6 -pre/rc kernels start when? next week? :)

--- linux-2.5.62/mm/fremap.c	2003-02-17 16:55:50.000000000 -0600
+++ linux-2.5.62-trivial/mm/fremap.c	2003-02-18 13:42:50.000000000 -0600
@@ -1,5 +1,5 @@
 /*
- *   linux/mm/mpopulate.c
+ *   linux/mm/fremap.c
  *=20
  * Explicit pagetable population and nonlinear (random) mappings support.
  *

--=-HB7f8+gfdcLbtvJnxvk9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEABECAAYFAj5Sjj4ACgkQg9lkBG+YkH/7sQCfdQ7akNyo5/1EIzdLKToTMPNj
Va4An3L2hzB6o7+Pz2VDvI39OCeyFXAF
=cppk
-----END PGP SIGNATURE-----

--=-HB7f8+gfdcLbtvJnxvk9--

