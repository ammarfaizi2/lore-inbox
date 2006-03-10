Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751067AbWCJLVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbWCJLVq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 06:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932215AbWCJLVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 06:21:46 -0500
Received: from mail27.syd.optusnet.com.au ([211.29.133.168]:27605 "EHLO
	mail27.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751067AbWCJLVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 06:21:45 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux list <linux-kernel@vger.kernel.org>
Subject: 2.6.15-ck7
Date: Fri, 10 Mar 2006 22:21:36 +1100
User-Agent: KMail/1.9.1
Cc: ck list <ck@vds.kolivas.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1253021.6UuflxW3Iz";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603102221.38779.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1253021.6UuflxW3Iz
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

These are patches designed to improve system responsiveness and interactivi=
ty.=20
It is configurable to any workload but the default ck patch is aimed at the=
=20
desktop and cks is available with more emphasis on serverspace.

This includes all patches from 2.6.15.6 so use 2.6.15 as your base.

Apply to 2.6.15
http://ck.kolivas.org/patches/2.6/2.6.15/2.6.15-ck7/patch-2.6.15-ck7.bz2

or server version
http://ck.kolivas.org/patches/cks/patch-2.6.15-cks7.bz2

web:
http://kernel.kolivas.org

all patches:
http://ck.kolivas.org/patches/

Split patches available.

Changes since 2.6.15-ck5 (last public announce)
=2D------
Added:
 +mm-swap_prefetch-tweaks.patch
Swap prefetching is supposed to work in an innocuous manner that isn't=20
noticeable. This patch corrects overzealous activity.


Removed:
 -nfs-fix_build.patch
Not needed with a correct fix in stable tree


Modified:
 -patch-2.6.15.5.bz2
 +patch-2.6.15.6.bz2
Updated to latest stable

 -2615ck5-version.patch
 +2615ck7-version.patch
Version update


Cheers,
Con

--nextPart1253021.6UuflxW3Iz
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEEWFCZUg7+tp6mRURAn3SAKCBlb18FFNWdsmcgX5sYKFW4clhHQCeKkwo
rjmWN8NJi9D/jtzUAs3c5BY=
=4Gws
-----END PGP SIGNATURE-----

--nextPart1253021.6UuflxW3Iz--
