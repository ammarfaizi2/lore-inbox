Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261501AbUJXOew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261501AbUJXOew (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 10:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbUJXOew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 10:34:52 -0400
Received: from mail14.syd.optusnet.com.au ([211.29.132.195]:61662 "EHLO
	mail14.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261501AbUJXOeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 10:34:44 -0400
Message-ID: <417BBD7E.8080803@kolivas.org>
Date: Mon, 25 Oct 2004 00:34:38 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux <linux-kernel@vger.kernel.org>
Cc: CK Kernel <ck@vds.kolivas.org>
Subject: Re: 2.6.9-ck2
References: <417BB099.1050501@kolivas.org>
In-Reply-To: <417BB099.1050501@kolivas.org>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC5D270E6F1A81BE43585A55D"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC5D270E6F1A81BE43585A55D
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Con Kolivas wrote:
> http://ck.kolivas.org/patches/2.6/2.6.9/2.6.9-ck2/patch-2.6.9-ck2.bz2

Looks like I forgot to include the buildfix from ck1 for the occasional 
compiler out there that has an "Internal Compiler Error" with 2.6.9 
building. If you are having that trouble, add this patch:

http://ck.kolivas.org/patches/2.6/2.6.9/2.6.9-ck2/patches/buildfix.diff

Sorry about that, comes from doing this so late at night...

Cheers,
Con

--------------enigC5D270E6F1A81BE43585A55D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBe71+ZUg7+tp6mRURAqMoAKCPCoED4DK/7kM3Kvy7RQh8MEnrTQCfXxIe
NnLNWw+HmInSdHwkK6bTJq8=
=59Eo
-----END PGP SIGNATURE-----

--------------enigC5D270E6F1A81BE43585A55D--
