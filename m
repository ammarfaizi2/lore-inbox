Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265033AbUGGPQl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265033AbUGGPQl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 11:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265203AbUGGPQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 11:16:40 -0400
Received: from mail005.syd.optusnet.com.au ([211.29.132.54]:42204 "EHLO
	mail005.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S265033AbUGGPQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 11:16:28 -0400
Message-ID: <40EC13C5.2000101@kolivas.org>
Date: Thu, 08 Jul 2004 01:16:21 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck kernel mailing list <ck@vds.kolivas.org>
Subject: 2.6.7-ck5
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigCA89A3BF748FFBA6111DC75F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCA89A3BF748FFBA6111DC75F
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Patchset update:

These are patches designed to improve system responsiveness with 
specific emphasis on the desktop, but suitable/configurable to any 
workload. Read details and FAQ on my web page.

http://kernel.kolivas.org


Added:
cfq bugfix
- cfq-bad-allocation.fix
security updates
- 1100_ip_tables.patch
- 1105_CAN-2004-0497.patch
- 1110_proc.patch


Updated:
Staircase cpu scheduler:
- from_2.6.7_to_staircase7.9
Batch (idle) scheduling:
- schedbatch2.2.diff
Isochronous (soft real time) scheduling:
- schediso2.2.diff
Graphical boot:
- bootsplash-3.1.4-sp3-2.6.7.diff


All patches:
-from_2.6.7_to_staircase7.9
-schedrange.diff
-schedbatch2.2.diff
-schediso2.2.diff
-autoswap.diff
-vm_autoregulate2.diff
-supermount-ng204.diff
-defaultcfq.diff
-config_hz.diff
-bootsplash-3.1.4-sp3-2.6.7.diff
-cfq-bad-allocation.fix
-1100_ip_tables.patch
-1105_CAN-2004-0497.patch
-1110_proc.patch
-ck5version.diff


Please feel free to send comments, queries, suggestions, patches.
Con

--------------enigCA89A3BF748FFBA6111DC75F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA7BPFZUg7+tp6mRURAp6CAJwIxlxRxsdI3pY2sFkmW4/nZfGnuwCfW8of
Mr+Y2D+xdfwU8+n7uox5zbE=
=IPn/
-----END PGP SIGNATURE-----

--------------enigCA89A3BF748FFBA6111DC75F--
