Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261363AbVBWNd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261363AbVBWNd5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 08:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261490AbVBWNd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 08:33:57 -0500
Received: from mail19.syd.optusnet.com.au ([211.29.132.200]:6336 "EHLO
	mail19.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261363AbVBWNdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 08:33:53 -0500
Message-ID: <421C863C.5010104@kolivas.org>
Date: Thu, 24 Feb 2005 00:33:48 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050223)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ck kernel <ck@vds.kolivas.org>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.10-ck6
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigCEDE1F742A4F52E99BD24311"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCEDE1F742A4F52E99BD24311
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

These are patches designed to improve system responsiveness. It is 
configurable to any workload but the default ck* patch is aimed at the 
desktop and ck*-server is available with more emphasis on serverspace.

This is a maintenance release and is identical to 2.6.10-ck5 apart from 
using 2.6.10-as5 with it's updated security and bugfixes for 2.6.10 
(thanks to Andres Salomon for maintaining this).

http://ck.kolivas.org/patches/2.6/2.6.10/2.6.10-ck6/


Full patchlist:
patch-2.6.10-as5
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
2610ck6-version.diff

and available separately:
supermount-ng208-10ck5.diff

Cheers,
Con

--------------enigCEDE1F742A4F52E99BD24311
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCHIY+ZUg7+tp6mRURAp26AKCRrnRIlfs41IbdQWDjPPTCJSWHowCfaDWH
iPR4bnunuGAHtmB+rFTpES8=
=HUOk
-----END PGP SIGNATURE-----

--------------enigCEDE1F742A4F52E99BD24311--
