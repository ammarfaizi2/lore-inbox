Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262701AbVE1LVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262701AbVE1LVv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 07:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262703AbVE1LVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 07:21:51 -0400
Received: from mail27.syd.optusnet.com.au ([211.29.133.168]:20459 "EHLO
	mail27.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262701AbVE1LVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 07:21:24 -0400
From: Con Kolivas <kernel@kolivas.org>
To: ck@vds.kolivas.org
Subject: 2.6.11-ck9
Date: Sat, 28 May 2005 21:21:51 +1000
User-Agent: KMail/1.8
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1384470.325sbV7I2e";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200505282121.53274.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1384470.325sbV7I2e
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

These are patches designed to improve system responsiveness and interactivi=
ty.=20
It is configurable to any workload but the default ck* patch is aimed at th=
e=20
desktop and ck*-server is available with more emphasis on serverspace.

Apply to 2.6.11 (includes patches from 2.6.11.11):
http://ck.kolivas.org/patches/2.6/2.6.11/2.6.11-ck9/patch-2.6.11-ck9.bz2
or
http://ck.kolivas.org/patches/2.6/2.6.11/2.6.11-ck9/patch-2.6.11-ck9-server=
=2Ebz2

web:
http://kernel.kolivas.org
all patches:
http://ck.kolivas.org/patches/
Split patches available.


Changes since 2.6.11-ck8:
=2Dpatch-2.6.11.9
+patch-2.6.11.11
Latest stable version

+2611ck9-smpnice.diff
Latest version of smp nice handling patch

=2D2611ck8-version.diff
+2611ck9-version.diff
Version number.


Cheers,
Con

--nextPart1384470.325sbV7I2e
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCmFRRZUg7+tp6mRURAq0PAJ9nG3hVshLnaq5BWZmWTi/+dxt00wCZAWpW
LzIDVqqW8oIE9MzAu5KYKys=
=doh6
-----END PGP SIGNATURE-----

--nextPart1384470.325sbV7I2e--
