Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750886AbWBKCA7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886AbWBKCA7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 21:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbWBKCA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 21:00:59 -0500
Received: from mail24.syd.optusnet.com.au ([211.29.133.165]:29628 "EHLO
	mail24.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750872AbWBKCA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 21:00:58 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck list <ck@vds.kolivas.org>
Subject: 2.6.15-ck4
Date: Sat, 11 Feb 2006 13:00:50 +1100
User-Agent: KMail/1.9
MIME-Version: 1.0
X-Length: 2932
Message-Id: <200602111300.52554.kernel@kolivas.org>
Content-Type: multipart/signed;
  boundary="nextPart1623240.MLANiEhiF7";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1623240.MLANiEhiF7
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

These are patches designed to improve system responsiveness and interactivi=
ty.=20
It is configurable to any workload but the default ck patch is aimed at the=
=20
desktop and cks is available with more emphasis on serverspace.

This includes all patches from 2.6.15.4 so use 2.6.15 as your base.

Apply to 2.6.15
http://ck.kolivas.org/patches/2.6/2.6.15/2.6.15-ck4/patch-2.6.15-ck4.bz2

or server version
http://ck.kolivas.org/patches/cks/patch-2.6.15-cks4.bz2

web:
http://kernel.kolivas.org

all patches:
http://ck.kolivas.org/patches/

Split patches available.


Changes
=2D------
Removed:
 -fix-scsi_cmd_cache_leak.patch
Rolled into latest stable patch


Modified:
 -patch-2.6.15.2.bz2
 +patch-2.6.15.4.bz2
Latest stable patch

=2D2615ck3-version.patch
+2615ck4-version.patch
Version update


Cheers,
Con

--nextPart1623240.MLANiEhiF7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD7UVUZUg7+tp6mRURAiXFAJ9H5zScqr2n3Bn0jGyZUhvgfVuEJgCbBLQF
R4NEc/JuSmKxfRVGG16LN70=
=FurZ
-----END PGP SIGNATURE-----

--nextPart1623240.MLANiEhiF7--
