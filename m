Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261882AbVCALw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261882AbVCALw6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 06:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261883AbVCALww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 06:52:52 -0500
Received: from mail20.syd.optusnet.com.au ([211.29.132.201]:35522 "EHLO
	mail20.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261882AbVCALwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 06:52:38 -0500
Message-Id: <200503012252.34807.kernel@kolivas.org>
Date: Tue, 1 Mar 2005 22:52:30 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050223)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ck kernel <ck@vds.kolivas.org>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.10-ck7
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
X-Length: 2380
Content-Type: multipart/signed;
  boundary="nextPart1125445.0lXeL1ozGd";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1125445.0lXeL1ozGd
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

These are patches designed to improve system responsiveness. It is=20
configurable to any workload but the default ck* patch is aimed at the=20
desktop and ck*-server is available with more emphasis on serverspace.

This is a maintenance release and is identical to 2.6.10-ck6 apart from=20
using 2.6.10-as6 with it's updated security and bugfixes for 2.6.10=20
(thanks to Andres Salomon for maintaining this).

http://ck.kolivas.org/patches/2.6/2.6.10/2.6.10-ck7/


=46ull patchlist:
patch-2.6.10-as6
2.6.10_to_staircase9.2.diff
schedrange.diff
schedbatch2.6.diff
schediso2.8.diff
mwII.diff
1g_lowmem1_i386.diff
defaultcfq.diff
2.6.10-mingoll.diff
cddvd-cmdfilter-drop.patch
vm-pageout-throttling.patch
nvidia_6111-6629_compat2.diff
fix-ll-resume.diff
s9.2_s9.3.diff
i2.8_i2.9.diff
s9.3_s9.4.diff
i2.9_i2.10.diff
b2.6_b2.7.diff
s9.4_s10.diff
s10_test1.diff
s10_s10.1.diff
s10.1_s10.2.diff
s10.2_s10.3.diff
1504_vmscan-writeback-pages.patch
s10.3_s10.4.diff
s10.4_s10.5.diff
2610ck7-version.diff

and available separately:
supermount-ng208-10ck5.diff

Cheers,
Con

--nextPart1125445.0lXeL1ozGd
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCJFeCZUg7+tp6mRURAkUKAJ9rQQO6jY6SATokJLhgVSNL3Y1SxgCgjBYH
ZN3y4cmphJOAjWnBTxUBu6g=
=5x29
-----END PGP SIGNATURE-----

--nextPart1125445.0lXeL1ozGd--
