Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269373AbUJWAXZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269373AbUJWAXZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 20:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269379AbUJWAXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 20:23:00 -0400
Received: from mail06.syd.optusnet.com.au ([211.29.132.187]:54998 "EHLO
	mail06.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S269361AbUJWAT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 20:19:58 -0400
Message-ID: <4179A39C.6080707@kolivas.org>
Date: Sat, 23 Oct 2004 10:19:40 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The naming wars continue...
References: <Pine.LNX.4.58.0410221431180.2101@ppc970.osdl.org> <20041022234631.GF28904@waste.org>
In-Reply-To: <20041022234631.GF28904@waste.org>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC6961DDF551DA50D15AB9301"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC6961DDF551DA50D15AB9301
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Matt Mackall wrote:
> On Fri, Oct 22, 2004 at 03:05:13PM -0700, Linus Torvalds wrote:
> 
>>And the fact is, I can't see the point. I'll just call it all "-rcX",
>>because I (very obviously) have no clue where the cut-over-point from
>>"pre" to "rc" is, or (even more painfully obviously) where it will become
>>the final next release.
> 
> 
> This should be easy: the cut-over should be when you're tempted to
> rename it 2.6.next. If you have no intention (or hope) of renaming
> 2.6.x-rc1 to 2.6.x, it is not a "release candidate" by definition.
> 
> What's the point? It serves as a signal that a) we're not accepting
> more big changes b) we think it's ready for primetime and needs
> serious QA c) when 2.6.next gets released, the _exact code_ has gone
> through a test cycle and we can have some confidence that there won't
> be any nasty 0-day bugs when we go to install 2.6.next on a production
> machine.

I have this feeling Linus is laughing at us when he debates these 
arguments. Nonetheless I finally feel obliged to say a "release 
candidate" is a release candidate. It should only be called that if it 
is planned to be the real version, and the real version is _exactly_ the 
same bar the version number. If it isn't even planned to be released 
unmodified it's a -pre patch.

/me still hears Linus laughing. He's only been doing this for 13 years.

Cheers,
Con

--------------enigC6961DDF551DA50D15AB9301
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBeaOcZUg7+tp6mRURAif/AKCM345gPxCgGmV41fiQQzqNVdiCAgCfZW6r
dLKFL22X6BEOIKWWpwEmPjo=
=O26u
-----END PGP SIGNATURE-----

--------------enigC6961DDF551DA50D15AB9301--
