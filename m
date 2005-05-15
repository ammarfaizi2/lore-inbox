Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261475AbVEOEAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261475AbVEOEAX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 00:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261466AbVEOEAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 00:00:23 -0400
Received: from mail01.syd.optusnet.com.au ([211.29.132.182]:53430 "EHLO
	mail01.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261475AbVEOEAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 00:00:13 -0400
From: Con Kolivas <kernel@kolivas.org>
To: ck@vds.kolivas.org,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.6.11-ck8
Date: Sun, 15 May 2005 14:00:33 +1000
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5412822.YH7f5a6OS1";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200505151400.37805.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart5412822.YH7f5a6OS1
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

These are patches designed to improve system responsiveness and interactivi=
ty.=20
It is configurable to any workload but the default ck* patch is aimed at th=
e=20
desktop and ck*-server is available with more emphasis on serverspace.

Apply to 2.6.11 (already contains latest 4 point stable release):
http://ck.kolivas.org/patches/2.6/2.6.11/2.6.11-ck8/patch-2.6.11-ck8.bz2
or
http://ck.kolivas.org/patches/2.6/2.6.11/2.6.11-ck8/patch-2.6.11-ck8-server=
=2Ebz2

web:
http://kernel.kolivas.org
all patches:
http://ck.kolivas.org/patches/
Split patches available.


Changes since 2.6.11-ck7:
+s11.1_s11.2.diff
Small staircase cpu scheduler update for variable overflow on 32bit. May ca=
use=20
noticeable improvements.

+patch-2.6.11.9
Latest stable version

+2611ck8-version.diff
=2Dpatch-2.6.11.8
=2D2611ck7-version.diff


Cheers,
Con

--nextPart5412822.YH7f5a6OS1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBChsllZUg7+tp6mRURAikKAKCH2DzN4Nq3wkK7Osq+4/inIiNghACeJ5lF
BeeAj4rnh2Kr8rY0TjuqbrE=
=08Vj
-----END PGP SIGNATURE-----

--nextPart5412822.YH7f5a6OS1--
