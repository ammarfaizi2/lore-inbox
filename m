Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271222AbUJVLiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271222AbUJVLiF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 07:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271226AbUJVLiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 07:38:04 -0400
Received: from mail01.syd.optusnet.com.au ([211.29.132.182]:34465 "EHLO
	mail01.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S271222AbUJVLhx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 07:37:53 -0400
Message-ID: <4178F108.1080101@kolivas.org>
Date: Fri, 22 Oct 2004 21:37:44 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux <linux-kernel@vger.kernel.org>
Subject: [PATCH] Staircase cpu scheduler v9.0
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF4DE7D8EBD6694C85940E4F8"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF4DE7D8EBD6694C85940E4F8
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The latest version of the staircase cpu scheduler policy rewrite is now 
available for 2.6.9 and 2.6.9-mm1. v9.0 is v8.K renamed to keep in sync 
with the mainline version numbering.

http://ck.kolivas.org/patches/2.6/2.6.9/2.6.9_to_staircase9.0.diff

http://ck.kolivas.org/patches/2.6/2.6.9/2.6.9-mm1/2.6.9-mm1_to_staircase9.0.diff

For those who are unaware, all the bugs that were brought to light in 
testing from the version in 2.6.8-rc2-mm2 till now have been addressed. 
Please retest if you have been waiting for a stable version. This is the 
same version that is in 2.6.9-ck1.

Cheers,
Con

--------------enigF4DE7D8EBD6694C85940E4F8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBePEOZUg7+tp6mRURAlqHAJ4rPYl2QffyGU9lPpX+N9ug+3WeOACeL2YX
gtY0EjQHqgUeErjF2p50WB4=
=tPyW
-----END PGP SIGNATURE-----

--------------enigF4DE7D8EBD6694C85940E4F8--
