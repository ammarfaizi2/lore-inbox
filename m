Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267294AbUHZAmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267294AbUHZAmG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 20:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267363AbUHZAmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 20:42:06 -0400
Received: from mail019.syd.optusnet.com.au ([211.29.132.73]:7875 "EHLO
	mail019.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S267294AbUHZAmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 20:42:02 -0400
Message-ID: <412D31D4.2050404@kolivas.org>
Date: Thu, 26 Aug 2004 10:41:56 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] Staircase cpu scheduler v8.1
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig38DECFAA6CDE4E469CC0C338"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig38DECFAA6CDE4E469CC0C338
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Latest version of the staircase cpu scheduler (v8.1) is available for 
2.6.8.1 and 2.6.9-rc1

http://ck.kolivas.org/patches/2.6/

Cheers,
Con

P.S. This is just a heads up since it was pointed out to me if I don't 
announce this on lkml people don't know it is being actively maintained.

--------------enig38DECFAA6CDE4E469CC0C338
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBLTHXZUg7+tp6mRURAtb0AJsHWZXEjQBbplLPXXDkzVj479xOmACghpfR
thHroP1VxEBTjxE8eRmGlvw=
=L4bP
-----END PGP SIGNATURE-----

--------------enig38DECFAA6CDE4E469CC0C338--
