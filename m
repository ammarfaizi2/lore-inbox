Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262789AbVF3ClL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262789AbVF3ClL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 22:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262790AbVF3ClK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 22:41:10 -0400
Received: from mail22.syd.optusnet.com.au ([211.29.133.160]:56754 "EHLO
	mail22.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262789AbVF3ClE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 22:41:04 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.6.12-ck3
Date: Thu, 30 Jun 2005 12:40:58 +1000
User-Agent: KMail/1.8.1
Cc: ck list <ck@vds.kolivas.org>
MIME-Version: 1.0
X-Length: 1432
Content-Type: multipart/signed;
  boundary="nextPart1146987.5FY818Et8K";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200506301241.00593.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1146987.5FY818Et8K
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

These are patches designed to improve system responsiveness and interactivi=
ty.=20
It is configurable to any workload but the default ck* patch is aimed at th=
e=20
desktop and ck*-server is available with more emphasis on serverspace.

Apply to 2.6.12 (This includes all patches in 2.6.12.2):
http://ck.kolivas.org/patches/2.6/2.6.12/2.6.12-ck3/patch-2.6.12-ck3.bz2
or for server version:
http://ck.kolivas.org/patches/2.6/2.6.12/2.6.12-ck3/patch-2.6.12-ck3-server=
=2Ebz2

web:
http://kernel.kolivas.org
all patches:
http://ck.kolivas.org/patches/
Split patches available.


Changes since 2.6.12-ck2:
+cfq-ts-2.diff
+cfq-ts-4.diff
Two cfq-timeslice updates from Jens

+patch-2.6.12.2
Latest stable version


This release is called "Baby Cigar" as this picture should explain:
http://ck.kolivas.org/patches/2.6/2.6.12/baby_cigar.JPG

Cheers,
Con

--nextPart1146987.5FY818Et8K
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCw1u8ZUg7+tp6mRURAlloAJ97JnYRvnUN3eAjyKKw7qJBi0YzwgCffmwm
eyaeeFS2LenEgMMq3Gx17Cc=
=4dYN
-----END PGP SIGNATURE-----

--nextPart1146987.5FY818Et8K--
