Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751251AbVJKAFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbVJKAFW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 20:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbVJKAFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 20:05:21 -0400
Received: from mail19.syd.optusnet.com.au ([211.29.132.200]:15025 "EHLO
	mail19.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751251AbVJKAFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 20:05:14 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.6.13-ck8
Date: Tue, 11 Oct 2005 10:05:06 +1000
User-Agent: KMail/1.8.2
Cc: ck list <ck@vds.kolivas.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3767739.EmgAcfxNYu";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200510111005.08151.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3767739.EmgAcfxNYu
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

These are patches designed to improve system responsiveness and interactivi=
ty.=20
It is configurable to any workload but the default ck* patch is aimed at th=
e=20
desktop and ck*-server is available with more emphasis on serverspace.


THIS INCLUDES ALL THE PATCHES IN 2.6.13.4 SO YOU SHOULD START WITH 2.6.13 T=
O=20
USE THESE PATCHES

Apply to 2.6.13
http://ck.kolivas.org/patches/2.6/2.6.13/2.6.13-ck8/patch-2.6.13-ck8.bz2

or server version
http://ck.kolivas.org/patches/2.6/2.6.13/2.6.13-ck8/patch-2.6.13-ck8-server=
=2Ebz2

web:
http://kernel.kolivas.org
all patches:
http://ck.kolivas.org/patches/
Split patches available.


Changes:

Added:
 +ck7_sp15.patch
 +sp15_sp16.patch
Bring swap prefetch up to the stable version. Swap prefetch is considered=20
stable as of v15.


Modified:
 -patch-2.6.13.3.bz2
 +patch-2.6.13.4.bz2
Latest stable tree

 -2613ck7-version.diff
 +2613ck8-version.diff
Version


=46ull patchlist:
sched-run_normal_with_rt_on_sibling.diff=20
2.6.13_to_staircase12.diff=20
schedrange.diff=20
schedbatch2.9.diff=20
sched-iso3.1.patch=20
sched-iso_tunables.patch=20
smp-nice-support7.diff=20
1g_lowmem1_i386.diff=20
defaultcfq.diff=20
isobatch_ionice2.diff=20
rt_ionice.diff=20
pdflush-tweaks.patch=20
hz-default_values.patch=20
vm-mapped.diff=20
vm-lots_watermark.diff=20
vm-background_scan.diff=20
vm-swap_prefetch-2.patch=20
sched-staircase12_tweak.patch=20
vm-sp2_sp5.patch=20
hz-no250.patch=20
vm-fix_background_scan.patch=20
vm-sp5_sp6.patch=20
vm-sp6_sp7.2.patch=20
ck5_sp11.patch=20
patch-2.6.13.4.bz2=20
sp11_sp14.patch=20
ck7_sp15.patch=20
sp15_sp16.patch=20
2613ck8-version.diff=20


Cheers,
Con

--nextPart3767739.EmgAcfxNYu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDSwG0ZUg7+tp6mRURAomZAJ9nkJL/ce75VyEg97bTYlcECajUswCeOaGq
eBqpT4rMNsoMJjQD47IRceo=
=QLaM
-----END PGP SIGNATURE-----

--nextPart3767739.EmgAcfxNYu--
