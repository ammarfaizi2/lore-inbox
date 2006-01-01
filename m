Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932139AbWAAIST@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbWAAIST (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 03:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbWAAIST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 03:18:19 -0500
Received: from mail25.syd.optusnet.com.au ([211.29.133.166]:54156 "EHLO
	mail25.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932139AbWAAISS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 03:18:18 -0500
From: Con Kolivas <kernel@kolivas.org>
To: ck list <ck@vds.kolivas.org>
Subject: 2.6.14-ck8
Date: Sun, 1 Jan 2006 19:18:08 +1100
User-Agent: KMail/1.8.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <200601011918.11619.kernel@kolivas.org>
X-Length: 2647
Content-Type: multipart/signed;
  boundary="nextPart1739839.2bOeYg93KO";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1739839.2bOeYg93KO
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Happy New Year!

These are patches designed to improve system responsiveness and interactivi=
ty.=20
It is configurable to any workload but the default ck patch is aimed at the=
=20
desktop and cks is available with more emphasis on serverspace.


THIS INCLUDES ALL PATCHES FROM 2.6.14.5 SO START WITH 2.6.14

Apply to 2.6.14
http://ck.kolivas.org/patches/2.6/2.6.14/2.6.14-ck8/patch-2.6.14-ck8.bz2

or server version
http://ck.kolivas.org/patches/cks/patch-2.6.14-cks8.bz2

web:
http://kernel.kolivas.org
all patches:
http://ck.kolivas.org/patches/
Split patches available.


Changes:

Modified:
 -patch-2.6.14.4.bz2
 +patch-2.6.14.5.bz2

Resync with stable tree

=2D2614ck7-version.diff
+2614ck8-version.diff

Version


=46ull patchlist:

2.6.14_to_staircase12.1.diff
schedrange.diff
schedbatch2.9.diff
sched-iso3.2.patch
smp-nice-support7.diff
1g_lowmem1_i386.diff
defaultcfq.diff
isobatch_ionice2.diff
rt_ionice.diff
pdflush-tweaks.patch
hz-default_values.patch
hz-no_default_250.patch
mm-swap_prefetch-19.patch
vm-mapped.diff
vm-lots_watermark.diff
vm-background_scan-1.diff
sched-staircase12.1_12.2.patch
mm-kswapd_inherit_prio.patch
mm-prio_dependant_scan.patch
mm-batch_prio.patch
sched-staircase12.2_13.patch
patch-2.6.14.5.bz2
2614ck8-version.diff


Cheers,
Con

--nextPart1739839.2bOeYg93KO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDt5BDZUg7+tp6mRURApMsAJ9nk/CHcGOXloI4wMFXQJIfc63wbACfdp/+
jus827CzH03blY25RZLiwnw=
=kbaD
-----END PGP SIGNATURE-----

--nextPart1739839.2bOeYg93KO--
