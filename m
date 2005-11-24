Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161076AbVKXX5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161076AbVKXX5L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 18:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161077AbVKXX5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 18:57:11 -0500
Received: from mail20.syd.optusnet.com.au ([211.29.132.201]:7916 "EHLO
	mail20.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1161076AbVKXX5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 18:57:10 -0500
From: Con Kolivas <kernel@kolivas.org>
To: ck list <ck@vds.kolivas.org>
Subject: 2.6.14-ck6
Date: Fri, 25 Nov 2005 10:57:00 +1100
User-Agent: KMail/1.8.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart7179538.IrFpdhqdaH";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200511251057.06263.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart7179538.IrFpdhqdaH
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

These are patches designed to improve system responsiveness and interactivi=
ty.=20
It is configurable to any workload but the default ck patch is aimed at the=
=20
desktop and cks is available with more emphasis on serverspace.


THIS INCLUDES ALL PATCHES FROM 2.6.14.3 SO START WITH 2.6.14

Apply to 2.6.14
http://ck.kolivas.org/patches/2.6/2.6.14/2.6.14-ck6/patch-2.6.14-ck6.bz2

or server version
http://ck.kolivas.org/patches/cks/patch-2.6.14-cks6.bz2

web:
http://kernel.kolivas.org
all patches:
http://ck.kolivas.org/patches/
Split patches available.


Changes:
Resync with stable tree only


Modified:
 -patch-2.6.14.2.bz2
 +patch-2.6.14.3.bz2
Resync with 2.6.14.3

 -2614ck5-version.diff
 +2614ck6-version.diff
Version update


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
mm-swap_prefetch-18.patch
vm-mapped.diff
vm-lots_watermark.diff
vm-background_scan-1.diff
sched-staircase12.1_12.2.patch
mm-kswapd_inherit_prio.patch
mm-prio_dependant_scan.patch
mm-batch_prio.patch
sched-staircase12.2_13.patch
patch-2.6.14.3.bz2
2614ck6-version.diff


Cheers,
Con

--nextPart7179538.IrFpdhqdaH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDhlNSZUg7+tp6mRURAl5nAJ4ignalpyPqDs/BdRd7JhNvQ1jRhACePDyb
q9ZLB+aB8PW87ROOJ4PypfY=
=I8FE
-----END PGP SIGNATURE-----

--nextPart7179538.IrFpdhqdaH--
