Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932156AbWFRHiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbWFRHiO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 03:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932165AbWFRHgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 03:36:49 -0400
Received: from mail29.syd.optusnet.com.au ([211.29.132.171]:14547 "EHLO
	mail29.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932156AbWFRHgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 03:36:41 -0400
From: Con Kolivas <kernel@kolivas.org>
To: ck list <ck@vds.kolivas.org>, linux list <linux-kernel@vger.kernel.org>
Subject: 2.6.17-ck1
Date: Sun, 18 Jun 2006 17:36:35 +1000
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Message-Id: <200606181736.38768.kernel@kolivas.org>
X-Length: 1201
Content-Type: multipart/signed;
  boundary="nextPart1235253.5jfCETAboX";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1235253.5jfCETAboX
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

These are patches designed to improve system responsiveness and interactivi=
ty.=20
It is configurable to any workload but the default ck patch is aimed at the=
=20
desktop and cks is available with more emphasis on serverspace.

Apply to 2.6.17
http://www.kernel.org/pub/linux/kernel/people/ck/patches/2.6/2.6.17/2.6.17-=
ck1/patch-2.6.17-ck1.bz2

or server version
http://www.kernel.org/pub/linux/kernel/people/ck/patches/cks/patch-2.6.17-c=
ks1.bz2

web:
http://kernel.kolivas.org

all patches:
http://www.kernel.org/pub/linux/kernel/people/ck/patches/

Split patches available.

=46ull patchlist:

sched-implement-smpnice-2.6.17.patch
sched-revise_smt_nice_locking.patch
2.6.17-smpnice-staircase-16.patch
sched-staircase16_interactive_tunable.patch
sched-staircase16_compute_tunable.patch
sched-range.patch
sched-iso-4.5.patch
track_mutexes-1.patch
sched-idleprio-1.9.patch
sched-limit_policy_changes.patch
defaultcfq.diff
cfq-ioprio_inherit_rt_class.patch
cfq-iso_idleprio_ionice.patch
hz-default_1000.patch
hz-no_default_250.patch
sched-add-above-background-load-function.patch
mm-swap_prefetch-32.patch
swsusp-rework-memory-shrinker-rev-2.patch
mm-convert_swappiness_to_mapped.patch
mm-lots_watermark.diff
mm-kswapd_inherit_prio-1.patch
mm-prio_dependant_scan-1.patch
mm-background_scan-1.patch
mm-idleprio_prio.patch
mm-decrease_minimum_dirty_ratio.patch
mm-set_zero_dirty_ratio.patch
mm-filesize_dependant_lru_cache_add.patch
fs-fcache-v2.1.patch
kconfig-expose_vmsplit_option.patch
2.6.17-ck1-version.patch

=2D-=20
=2Dck

--nextPart1235253.5jfCETAboX
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBElQKGZUg7+tp6mRURAtNgAJ9d0rAQ77u8pjoGISTdHNjv4NHKdgCfZa+C
Vexbwcfz9Ol+V+pQa12X5XQ=
=qdZL
-----END PGP SIGNATURE-----

--nextPart1235253.5jfCETAboX--
