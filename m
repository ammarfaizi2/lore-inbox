Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbUJXWgm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbUJXWgm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 18:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbUJXWgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 18:36:41 -0400
Received: from mail04.syd.optusnet.com.au ([211.29.132.185]:34479 "EHLO
	mail04.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261602AbUJXWg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 18:36:29 -0400
Message-ID: <417C2E5F.3020906@kolivas.org>
Date: Mon, 25 Oct 2004 08:36:15 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rafal Bujnowski <fergot@aster.net.pl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       CK Kernel <ck@vds.kolivas.org>
Subject: Re: 2.6.9-ck2
References: <417BB099.1050501@kolivas.org> <1098641857.2416.9.camel@moon.localnet>
In-Reply-To: <1098641857.2416.9.camel@moon.localnet>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig36C9BEA261314E0269768386"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig36C9BEA261314E0269768386
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Rafal Bujnowski wrote:
> On Sun, 2004-10-24 at 23:39 +1000, Con Kolivas wrote:
> 
> 
>>These are patches designed to improve system responsiveness with
>>specific emphasis on the desktop, but configurable to any workload.
> 
> 
> Hello Con,
> 
> I have a question regarding supermount patch. Is it applied into your
> patch set? I tried to find it in 2.6.9-ck1/ck2, and... I think it isn't.

As I explained previously: I will continue to maintain the supermount 
patch due to popular request. However since it adds no performance 
feature to -ck and makes the patchset more complicated making debugging 
more difficult I will not include it by default. Having said that, I 
haven't had any bug reports about it in a long time. It's a simple 
matter to add it to -ck if you want it.

Cheers,
Con

--------------enig36C9BEA261314E0269768386
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBfC5fZUg7+tp6mRURAoFUAJ9MgatkmtCmB8z5EmsLp+4KhN3ZQgCfQ1ia
nbxHrh5T/55msWcyoaaLid8=
=pBjH
-----END PGP SIGNATURE-----

--------------enig36C9BEA261314E0269768386--
