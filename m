Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267716AbTBRTwz>; Tue, 18 Feb 2003 14:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267817AbTBRTwz>; Tue, 18 Feb 2003 14:52:55 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:63450 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267716AbTBRTwy>; Tue, 18 Feb 2003 14:52:54 -0500
Subject: [TRIVIAL] remap->mremap
From: Paul Larson <plars@austin.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <1045597759.28493.208.camel@plars>
References: <1045597759.28493.208.camel@plars>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-GT+41ZWCQ4IFUnYZZm1z"
X-Mailer: Ximian Evolution 1.0.5 
Date: 18 Feb 2003 13:56:44 -0600
Message-Id: <1045598206.28493.211.camel@plars>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-GT+41ZWCQ4IFUnYZZm1z
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

missed one

--- linux-2.5.62/mm/mremap.c	2003-02-17 16:56:16.000000000 -0600
+++ linux-2.5.62-trivial/mm/mremap.c	2003-02-18 13:44:20.000000000 -0600
@@ -1,5 +1,5 @@
 /*
- *	mm/remap.c
+ *	mm/mremap.c
  *
  *	(C) Copyright 1996 Linus Torvalds
  *


--=-GT+41ZWCQ4IFUnYZZm1z
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEABECAAYFAj5Sj/wACgkQg9lkBG+YkH8jSQCdEBl10fvKMn+b+uVXXr+bcYMC
Q2UAnRd47ro09h4nrA5ekCuDTLJL50Kk
=hexm
-----END PGP SIGNATURE-----

--=-GT+41ZWCQ4IFUnYZZm1z--

