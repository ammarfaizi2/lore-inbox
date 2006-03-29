Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbWC2MBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbWC2MBj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 07:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbWC2MBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 07:01:39 -0500
Received: from mail26.syd.optusnet.com.au ([211.29.133.167]:5088 "EHLO
	mail26.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750780AbWC2MBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 07:01:38 -0500
From: Con Kolivas <kernel@kolivas.org>
To: ck list <ck@vds.kolivas.org>
Subject: 2.6.16-ck2
Date: Wed, 29 Mar 2006 22:01:29 +1000
User-Agent: KMail/1.9.1
Cc: linux list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1987516.mjxi2vYcEm";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603292201.32192.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1987516.mjxi2vYcEm
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

These are patches designed to improve system responsiveness and interactivi=
ty.=20
It is configurable to any workload but the default ck patch is aimed at the=
=20
desktop and cks is available with more emphasis on serverspace.

THESE INCLUDE THE PATCHES FROM 2.6.16.1 SO START WITH 2.6.16 AS YOUR BASE

Apply to 2.6.16
http://ck.kolivas.org/patches/2.6/2.6.16/2.6.16-ck2/patch-2.6.16-ck2.bz2

or server version
http://ck.kolivas.org/patches/cks/patch-2.6.16-cks2.bz2

web:
http://kernel.kolivas.org

all patches:
http://ck.kolivas.org/patches/

Split patches available.


Changes:

Added:
 +kbuild-dont-rely-on-incorrect-gnu-make-behavior.patch
An change in kbuild meant that the whole kernel would be recompiled every=20
single time you rebuilt it. This patch corrects that issue (thanks =20
Arthur Othieno for backporting)

 +patch-2.6.16.1.bz2
Latest stable version


Modified:
 -2.6.16-ck1-version.patch
 +2.6.16-ck2-version.patch
Version update


Cheers,
Con

--nextPart1987516.mjxi2vYcEm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEKnccZUg7+tp6mRURAibGAJ9XieonGe5+ZIKoci+3v3t0+mJCNwCcDUoy
IG//wHp1BxlEec6CEhaVuhY=
=CdwS
-----END PGP SIGNATURE-----

--nextPart1987516.mjxi2vYcEm--
