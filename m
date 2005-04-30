Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261227AbVD3OR3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbVD3OR3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 10:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261230AbVD3OR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 10:17:29 -0400
Received: from mail02.syd.optusnet.com.au ([211.29.132.183]:4840 "EHLO
	mail02.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261227AbVD3ORU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 10:17:20 -0400
From: Con Kolivas <kernel@kolivas.org>
To: ck@vds.kolivas.org,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.6.11-ck6
Date: Sun, 1 May 2005 00:17:33 +1000
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1221434.kkyYJ2YOlm";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200505010017.36907.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1221434.kkyYJ2YOlm
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

These are patches designed to improve system responsiveness. It is=20
configurable to any workload but the default ck* patch is aimed at the=20
desktop and ck*-server is available with more emphasis on serverspace.

Apply to 2.6.11 (already contains latest 4 point stable release):
http://ck.kolivas.org/patches/2.6/2.6.11/2.6.11-ck6/patch-2.6.11-ck6.bz2
or
http://ck.kolivas.org/patches/2.6/2.6.11/2.6.11-ck6/patch-2.6.11-ck6-server=
=2Ebz2

web:
http://kernel.kolivas.org
all patches:
http://ck.kolivas.org/patches/
Split patches available.


Changes since 2.6.11-ck4 (last public announcement):
Added:
+2.6.11-ck4_to_staircase11.diff
Update to new version of staircase announced on mailing list
+s11_s11.1.diff
New staircase specific scalability improvements

+scsi-dead-device.diff
A fix for a scsi related hang that seems to hit many -ck users

+patch-2.6.11.8
Latest stable tree

+2611ck6-version.diff
Reinstate the Australian animal that's woozy from cognac


Removed:
=2Dpatch-2.6.11.7
=2D2611ck4-version.diff


And don't forget to pour one of these before booting this kernel:
http://ck.kolivas.org/patches/2.6/2.6.11/cognac.JPG


Cheers,
Con

--nextPart1221434.kkyYJ2YOlm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCc5OAZUg7+tp6mRURAkAXAJ0ZQbPanmcIzKBmQKgDQ6TPheZAIgCffofu
YWFR1PrLDKp13+FCQUkDXP8=
=0b0L
-----END PGP SIGNATURE-----

--nextPart1221434.kkyYJ2YOlm--
