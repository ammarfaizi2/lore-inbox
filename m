Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267450AbUJWFpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267450AbUJWFpj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 01:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269297AbUJWFmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 01:42:11 -0400
Received: from mail06.syd.optusnet.com.au ([211.29.132.187]:2494 "EHLO
	mail06.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266821AbUJWFiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 01:38:22 -0400
Message-ID: <4179EE45.9080409@kolivas.org>
Date: Sat, 23 Oct 2004 15:38:13 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Alastair Stevens <alastair@altruxsolutions.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-ck1: swap mayhem under UT2004
References: <200410222346.32823.alastair@altruxsolutions.co.uk> <41799FE0.1020403@kolivas.org> <4179ED80.5090800@yahoo.com.au>
In-Reply-To: <4179ED80.5090800@yahoo.com.au>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig13F726F3C7493681083EB3E3"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig13F726F3C7493681083EB3E3
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Nick Piggin wrote:
> Con Kolivas wrote:
> 
>> Alastair Stevens wrote:
> 
> 
>>> Any ideas?  Any more info required?
>>
>>
>>
>> I've seen reports of this happening since 2.6.9 _even on mainline_. 
>> Something seems very sick with kswapd where it consumes massive 
>> amounts of cpu. Can you reproduce without any -ck patches? Others have 
>> already done so, but it seems to happen earlier with -ck.
>>
> 
> Where are the bug reports, please? I haven't seen any on lkml, but
> I haven't been following too closely for the past few days.
> 
> Thanks
> Nick

Lurking on the gentoo forums will reveal this:
http://forums.gentoo.org/viewtopic.php?t=239686&postdays=0&postorder=asc&start=50

Cheers
Con

--------------enig13F726F3C7493681083EB3E3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBee5FZUg7+tp6mRURAkZmAJ0fiyfErtNpcXWCOUzLe1HZb0TaIgCghIcR
HLj1GO9f2kLDveQUsCY4Dtc=
=cm48
-----END PGP SIGNATURE-----

--------------enig13F726F3C7493681083EB3E3--
