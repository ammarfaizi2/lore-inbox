Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261854AbVFLNWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261854AbVFLNWA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 09:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262494AbVFLNV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 09:21:59 -0400
Received: from mail18.syd.optusnet.com.au ([211.29.132.199]:28808 "EHLO
	mail18.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261854AbVFLNVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 09:21:45 -0400
From: Con Kolivas <kernel@kolivas.org>
To: ck list <ck@vds.kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.6.11-ck10
Date: Sun, 12 Jun 2005 23:21:39 +1000
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2213989.RsBQGizy9i";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200506122321.41894.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2213989.RsBQGizy9i
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

These are patches designed to improve system responsiveness and interactivi=
ty.=20
It is configurable to any workload but the default ck* patch is aimed at th=
e=20
desktop and ck*-server is available with more emphasis on serverspace.

Apply to 2.6.11 (this includes all the patches from 2.6.11.12):
http://ck.kolivas.org/patches/2.6/2.6.11/2.6.11-ck10/patch-2.6.11-ck10.bz2
or
http://ck.kolivas.org/patches/2.6/2.6.11/2.6.11-ck10/patch-2.6.11-ck10-serv=
er.bz2

web:
http://kernel.kolivas.org
all patches:
http://ck.kolivas.org/patches/
Split patches available.


Changes since 2.6.11-ck9:
=2Dpatch-2.6.11.11
+patch-2.6.11.12
 Latest stable version

+2611ck9-smpnice-fix1.diff
 A fix for smp nice calculations

+s11.2_s11.3.diff
 Update the staircase cpu scheduler to the latest version which includes th=
e=20
interactivity fix for recent changes in pipe behaviour

=2D2611ck9-version.diff
+2611ck10-version.diff
 Version


Cheers,
Con

--nextPart2213989.RsBQGizy9i
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCrDblZUg7+tp6mRURApTSAJ9VUU9Kd2npddHYL0JEeuZzGpmrSwCcDhm6
FDmxtpEFtuxKxfj5XxXtbWQ=
=gPDf
-----END PGP SIGNATURE-----

--nextPart2213989.RsBQGizy9i--
