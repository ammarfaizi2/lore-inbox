Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261311AbVAROyD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbVAROyD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 09:54:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbVAROyC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 09:54:02 -0500
Received: from mail25.syd.optusnet.com.au ([211.29.133.166]:53643 "EHLO
	mail25.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261311AbVAROxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 09:53:50 -0500
Message-ID: <41ED22F6.7040704@kolivas.org>
Date: Wed, 19 Jan 2005 01:53:42 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
Cc: linux <linux-kernel@vger.kernel.org>, CK Kernel <ck@vds.kolivas.org>
Subject: Re: [PATCH][RFC] sched: Isochronous class for unprivileged soft rt
 scheduling
References: <41ED08AB.5060308@kolivas.org>
In-Reply-To: <41ED08AB.5060308@kolivas.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB1B3824E5CF1D1013267EBCB"
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB1B3824E5CF1D1013267EBCB
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Con Kolivas wrote:
> This patch for 2.6.11-rc1 provides a method of providing real time
> scheduling to unprivileged users which increasingly is desired for
> multimedia workloads.

I should have mentioned. Many thanks to Alex Nyberg for generous 
debugging help.

Cheers,
Con

--------------enigB1B3824E5CF1D1013267EBCB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB7SL2ZUg7+tp6mRURAg4YAKCUpgxb2EMYc+9+E/ccmFYHX8NFpACfYErE
e+/4n0rWxtjGCxlH/8Ou04M=
=gXea
-----END PGP SIGNATURE-----

--------------enigB1B3824E5CF1D1013267EBCB--
