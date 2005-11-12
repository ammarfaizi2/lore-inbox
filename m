Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750865AbVKLBQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbVKLBQw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 20:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750881AbVKLBQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 20:16:52 -0500
Received: from mail07.syd.optusnet.com.au ([211.29.132.188]:17342 "EHLO
	mail07.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750863AbVKLBQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 20:16:52 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.6.14-ck5
Date: Sat, 12 Nov 2005 12:16:45 +1100
User-Agent: KMail/1.8.3
Cc: ck list <ck@vds.kolivas.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5397682.gCExB1xXx7";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200511121216.48145.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart5397682.gCExB1xXx7
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

These are patches designed to improve system responsiveness and interactivi=
ty.=20
It is configurable to any workload but the default ck patch is aimed at the=
=20
desktop and cks is available with more emphasis on serverspace.


THIS INCLUDES ALL PATCHES FROM 2.6.14.2 SO START WITH 2.6.14

Apply to 2.6.14
http://ck.kolivas.org/patches/2.6/2.6.14/2.6.14-ck5/patch-2.6.14-ck5.bz2

or server version
http://ck.kolivas.org/patches/cks/patch-2.6.14-cks5.bz2

web:
http://kernel.kolivas.org
all patches:
http://ck.kolivas.org/patches/
Split patches available.


Changes:
Resync with stable tree only


Modified:
 -patch-2.6.14.1
 -net-fix_zero-size_datagram_reception.patch
 +patch-2.6.14.2.bz2
Resync with 2.6.14.2

 -2614ck4-version.diff
 +2614ck5-version.diff
Version update


=46ull patchlist:

2.6.14_to_staircase12.1.diff=20
schedrange.diff=20
schedbatch2.9.diff=20
sched-iso3.2.patch=20
smp-nice-support7.diff=20
1g_lowmem1_i386.diff=20
defaultcfq.diff=20
isobatch_ionice2.diff=20
rt_ionice.diff=20
pdflush-tweaks.patch=20
hz-default_values.patch=20
hz-no_default_250.patch=20
mm-swap_prefetch-18.patch=20
vm-mapped.diff=20
vm-lots_watermark.diff=20
vm-background_scan-1.diff=20
sched-staircase12.1_12.2.patch=20
mm-kswapd_inherit_prio.patch=20
mm-prio_dependant_scan.patch=20
mm-batch_prio.patch=20
sched-staircase12.2_13.patch=20
patch-2.6.14.2.bz2=20
2614ck5-version.diff=20


Cheers,
Con

--nextPart5397682.gCExB1xXx7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDdUKAZUg7+tp6mRURAovXAJ9lUdpAMQ1ESLDE/hn8k8qESunEHQCfRuCb
oh9Vi5rx4eEmPIy4YaTMJOg=
=00xx
-----END PGP SIGNATURE-----

--nextPart5397682.gCExB1xXx7--
