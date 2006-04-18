Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932198AbWDRLZG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbWDRLZG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 07:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932199AbWDRLZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 07:25:06 -0400
Received: from mail22.syd.optusnet.com.au ([211.29.133.160]:52866 "EHLO
	mail22.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932198AbWDRLZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 07:25:05 -0400
From: Con Kolivas <kernel@kolivas.org>
To: ck list <ck@vds.kolivas.org>, linux list <linux-kernel@vger.kernel.org>
Subject: 2.6.16-ck6
Date: Tue, 18 Apr 2006 21:24:47 +1000
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Message-Id: <200604182124.50968.kernel@kolivas.org>
X-Length: 1881
Content-Type: multipart/signed;
  boundary="nextPart1594923.1CRS2UY1mI";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1594923.1CRS2UY1mI
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

These are patches designed to improve system responsiveness and interactivi=
ty.=20
It is configurable to any workload but the default ck patch is aimed at the=
=20
desktop and cks is available with more emphasis on serverspace.

THESE INCLUDE THE PATCHES FROM 2.6.16.7 SO START WITH 2.6.16 AS YOUR BASE

Apply to 2.6.16
http://www.kernel.org/pub/linux/kernel/people/ck/patches/2.6/2.6.16/2.6.16-=
ck6/patch-2.6.16-ck6.bz2

or server version
http://www.kernel.org/pub/linux/kernel/people/ck/patches/cks/patch-2.6.16-c=
ks6.bz2

web:
http://kernel.kolivas.org

all patches:
http://www.kernel.org/pub/linux/kernel/people/ck/patches/

Split patches available.


Changes:

Added:
 +sched-s15_test2.patch
=46ix for frequently forking tasks with staircase cpu scheduler


Modified:
 -patch-2.6.16.5
 +patch-2.6.16.7
Resync with mainline

 -2.6.16-ck5-version.patch
 +2.6.16-ck6-version.patch
Version update

=2D-=20
=2Dck

--nextPart1594923.1CRS2UY1mI
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBERMyCZUg7+tp6mRURAkQpAJ9Klgb21c8bFnJ7p9iH4TMhBAwqTwCcDqYn
9V8mYOb7aM1wOeOvNsLGHuw=
=CqWY
-----END PGP SIGNATURE-----

--nextPart1594923.1CRS2UY1mI--
