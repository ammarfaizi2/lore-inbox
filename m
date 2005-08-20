Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030184AbVHTDjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030184AbVHTDjh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 23:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030186AbVHTDjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 23:39:37 -0400
Received: from mail11.syd.optusnet.com.au ([211.29.132.192]:22982 "EHLO
	mail11.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1030184AbVHTDjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 23:39:37 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.12-ck6
Date: Sat, 20 Aug 2005 13:39:26 +1000
User-Agent: KMail/1.8.2
Cc: ck list <ck@vds.kolivas.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1627733.QL1AahCfEk";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200508201339.28730.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1627733.QL1AahCfEk
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

These are patches designed to improve system responsiveness and interactivi=
ty.=20
It is configurable to any workload but the default ck* patch is aimed at th=
e=20
desktop and ck*-server is available with more emphasis on serverspace.

Apply to 2.6.12 (This includes all patches in 2.6.12.5):
http://ck.kolivas.org/patches/2.6/2.6.12/2.6.12-ck6/patch-2.6.12-ck6.bz2
or for server version:
http://ck.kolivas.org/patches/2.6/2.6.12/2.6.12-ck6/patch-2.6.12-ck6-server=
=2Ebz2

web:
http://kernel.kolivas.org
all patches:
http://ck.kolivas.org/patches/
Split patches available.


Changes since 2.6.12-ck5:
=2Dpatch-2.6.12.4.bz2
+patch-2.6.12.5.bz2
Latest stable version

+s11.4_s11.6.diff
Updated staircase to account for delayed timer ticks.

+smpnice6-smpnice7.diff
A fix for a rare race in the smp nice code

=2D2612ck5-version.diff
+2612ck6-version.diff
Version


Cheers,
Con

--nextPart1627733.QL1AahCfEk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDBqXwZUg7+tp6mRURAm37AJ9BwOc36LH9lDqkvKhYk4MJsbKT3QCgk+dS
48ZA/eCW2XgbVYjdCDf8ls0=
=5QNQ
-----END PGP SIGNATURE-----

--nextPart1627733.QL1AahCfEk--
