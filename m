Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751258AbWEHLZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbWEHLZU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 07:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbWEHLZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 07:25:19 -0400
Received: from mail25.syd.optusnet.com.au ([211.29.133.166]:37766 "EHLO
	mail25.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751258AbWEHLZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 07:25:18 -0400
From: Con Kolivas <kernel@kolivas.org>
To: ck list <ck@vds.kolivas.org>, linux list <linux-kernel@vger.kernel.org>
Subject: 2.6.16-ck10
Date: Mon, 8 May 2006 21:25:11 +1000
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1760483.HWXZDIpoBX";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200605082125.15269.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1760483.HWXZDIpoBX
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

These are patches designed to improve system responsiveness and interactivi=
ty.=20
It is configurable to any workload but the default ck patch is aimed at the=
=20
desktop and cks is available with more emphasis on serverspace.

THESE INCLUDE THE PATCHES FROM 2.6.16.14 SO START WITH 2.6.16 AS YOUR BASE

Apply to 2.6.16
http://www.kernel.org/pub/linux/kernel/people/ck/patches/2.6/2.6.16/2.6.16-=
ck10/patch-2.6.16-ck10.bz2

or server version
http://www.kernel.org/pub/linux/kernel/people/ck/patches/cks/patch-2.6.16-c=
ks10.bz2

web:
http://kernel.kolivas.org

all patches:
http://www.kernel.org/pub/linux/kernel/people/ck/patches/

Split patches available.


Changes since 2.6.16-ck9:

Added:
 +mm-swap_prefetch_fix.patch
Locking fox for swap prefetch thanks to Ingo Molnar


Modified:
 -patch-2.6.16.12
 +patch-2.6.16.14
Resync with mainline

 -2.6.16-ck9-version.patch
 +2.6.16-ck10-version.patch
Version update


=46ull patchlist:

sched-implement-smpnice.patch
sched-smpnice-apply-review-suggestions.patch
sched-smpnice-fix-average-load-per-run-queue-calculations.patch
sched-store-weighted-load-on-up.patch
sched-add-discrete-weighted-cpu-load-function.patch
sched-add-above-background-load-function.patch
sched-staircase14.2.patch
sched-generic_optims2.patch
schedrange-2.diff
sched-iso-4.1.patch
sched-idleprio-1.2.patch
sched-staircase14.2_15.patch
defaultcfq.diff
iso_idleprio_ionice.patch
rt_ionice.diff
pdflush-tweaks.patch
hz-default_values.patch
hz-no_default_250.patch
mm-swap_prefetch-30.patch
vm-mapped-1.diff
vm-lots_watermark.diff
mm-background_scan.patch
mm-kswapd_inherit_prio-1.patch
mm-prio_dependant_scan-1.patch
mm-idleprio_prio.patch
sp-resume1.patch
mm-aggresive_swap_prefetch.patch
swsusp-post_resume_aggressive_swap_prefetch-1.patch
adaptive-readahead-11.patch
kbuild-dont-rely-on-incorrect-gnu-make-behavior.patch
sched-s15_test2.patch
sched-fix_idleprio.patch
mm-swap_prefetch_fix.patch
patch-2.6.16.14
2.6.16-ck10-version.patch

=2D-=20
=2Dck

--nextPart1760483.HWXZDIpoBX
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEXyqbZUg7+tp6mRURAp4GAJ9WKIa4yZbh1Qky3n2qbHg0qfdZdACeP13x
zkki79SmnwiM2PAl+7Omt24=
=BDPo
-----END PGP SIGNATURE-----

--nextPart1760483.HWXZDIpoBX--
