Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750841AbWIUO34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbWIUO34 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 10:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbWIUO3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 10:29:55 -0400
Received: from mail04.syd.optusnet.com.au ([211.29.132.185]:15305 "EHLO
	mail04.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750870AbWIUO3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 10:29:55 -0400
From: Con Kolivas <kernel@kolivas.org>
To: ck mailing list <ck@vds.kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.6.18-ck1
Date: Fri, 22 Sep 2006 00:29:46 +1000
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Message-Id: <200609220029.49464.kernel@kolivas.org>
X-Length: 2613
Content-Type: multipart/signed;
  boundary="nextPart23182647.TTsGmmqpsy";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart23182647.TTsGmmqpsy
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

This patchset is designed to improve system responsiveness and interactivit=
y.=20
It is configurable to any workload but the default -ck patch is aimed at th=
e=20
desktop and -cks is available with more emphasis on serverspace.

Apply to 2.6.18
http://www.kernel.org/pub/linux/kernel/people/ck/patches/2.6/2.6.18/2.6.18-=
ck1/patch-2.6.18-ck1.bz2

or server version
http://www.kernel.org/pub/linux/kernel/people/ck/patches/cks/patch-2.6.18-c=
ks1.bz2

web:
http://kernel.kolivas.org

all patches:
http://www.kernel.org/pub/linux/kernel/people/ck/patches/

Split patches available.

=46ull patchlist:

sched-staircase-16.2.patch
sched-staircase16_interactive_tunable.patch
sched-staircase16_compute_tunable.patch
sched-range.patch
sched-iso-4.6.patch
track_mutexes-1.patch
sched-idleprio-1.11.patch
sched-limit_policy_changes.patch
cfq-ioprio_inherit_rt_class.patch
cfq-iso_idleprio_ionice.patch
hz-default_1000.patch=20
hz-no_default_250.patch=20
sched-add-above-background-load-function.patch
mm-swap_prefetch-33.patch=20
mm-convert_swappiness_to_mapped.patch=20
mm-lots_watermark.diff=20
mm-kswapd_inherit_prio-1.patch=20
mm-prio_dependant_scan-1.patch=20
mm-background_scan-2.patch
mm-idleprio_prio.patch
mm-decrease_minimum_dirty_ratio.patch
mm-set_zero_dirty_ratio.patch
mm-filesize_dependant_lru_cache_add.patch
kconfig-expose_vmsplit_option.patch
ck1-version.patch

=E6=A5=BD=E3=81=97=E3=81=BF=E3=81=AA=E3=81=95=E3=81=84

=2D-=20
=2Dck

--nextPart23182647.TTsGmmqpsy
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBFEqHdZUg7+tp6mRURAgMMAJ9mnht0j6LXyFXyDfU3plnkbj7GbwCeO9qk
AffR7bo2o7gvBUWcrSfc4oc=
=9vxD
-----END PGP SIGNATURE-----

--nextPart23182647.TTsGmmqpsy--
