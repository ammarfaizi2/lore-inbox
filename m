Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262216AbUKKL74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262216AbUKKL74 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 06:59:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262220AbUKKL7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 06:59:53 -0500
Received: from mail11.syd.optusnet.com.au ([211.29.132.192]:53396 "EHLO
	mail11.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262216AbUKKL7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 06:59:11 -0500
Message-ID: <41935406.2000705@kolivas.org>
Date: Thu, 11 Nov 2004 22:59:02 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux <linux-kernel@vger.kernel.org>
Cc: Peter Williams <pwil3058@bigpond.net.au>
Subject: plugsched for 2.6.10-rc1-mm5
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig97951143C7E15F85B1C16EEF"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig97951143C7E15F85B1C16EEF
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

A resync of the pluggable cpu scheduler framework is available.

http://ck.kolivas.org/patches/plugsched/2.6.10-rc1-mm5/

Changes in this release:
Patches from Peter Williams to share more schedstats code and the cpu 
accounting were rolled up into the patchset.

Cheers,
Con

--------------enig97951143C7E15F85B1C16EEF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBk1QIZUg7+tp6mRURAnLlAJwMyKCpBNlonl8pbXp/ifmb280elwCfb5b/
b0TPD5BEpj2Z3tTp6ixd8YI=
=ZAwp
-----END PGP SIGNATURE-----

--------------enig97951143C7E15F85B1C16EEF--
